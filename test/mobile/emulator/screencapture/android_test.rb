require "test_helper"

class Mobile::Emulator::Screencapture::AndroidTest < Minitest::Test
  def setup
    @android = Mobile::Emulator::Screencapture.create(
      platform: "android",
      screenshot_dir: "./screenshot",
      screenrecord_dir: "./screenrecord"
    )

    @android.stubs(:_adb)
  end

  def test_screenshot
    assert_equal @android.screenshot("test_image"), "#{@android.screenshot_dir}/test_image.png"
  end

  def test_screenrecord
    @android.stubs(:_native_start_screenrecord).returns(1)
    @android.expects(:_native_stop_screenrecord)
    @android.expects(:_pull_screenrecord)

    @android.start_screenrecord("test")
    assert_equal @android.stop_screenrecord, "#{@android.screenrecord_dir}/test.mp4"
  end

  def test_start_screenrecord_with_options
    android = Mobile::Emulator::Screencapture.create(
      platform: "android",
      screenshot_dir: "./screenshot",
      screenrecord_dir: "./screenrecord",
      width: 1280,
      height: 800,
      bit_rate: 6_000_000,
      time_limit: 180,
    )

    command = ["shell screencap #{android.class::DEVICE_SCREENRECORD_PATH}"]
    command << "--size #{android.width}x#{android.height}"
    command << "--bit-rate #{android.bit_rate}"
    command << "--time-limit #{android.time_limit}"
    expect = command.join(" ")

    android.expects(:_adb).with(equals(expect))

    android.start_screenrecord("test")
  end

  def test_start_screenrecord_when_duplicate_starting
    @android.stubs(:_native_start_screenrecord).returns(1)

    @android.start_screenrecord("test")
    assert_raises RuntimeError, "Raise error when duplicate starting screenrecord" do
      @android.start_screenrecord("foo")
    end
  end

  def test_stop_screenrecord_when_before_starting
    @android.stubs(:_native_start_screenrecord).returns(1)

    assert_raises RuntimeError, "Raise error stop screenrecord before starting" do
      @android.stop_screenrecord
    end
  end
end

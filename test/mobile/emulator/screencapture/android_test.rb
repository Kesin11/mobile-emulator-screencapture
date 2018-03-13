require "test_helper"

class Mobile::Emulator::Screencapture::AndroidTest < Minitest::Test
  def setup
    @android = Mobile::Emulator::Screencapture.create(
      platform: "android",
      screenshot_dir: "./screenshot"
    )
  end

  def test_screenshot
    @android.stubs(:_adb)

    assert_equal @android.screenshot("test_image"), "#{@android.screenshot_dir}/test_image.png"
  end
end

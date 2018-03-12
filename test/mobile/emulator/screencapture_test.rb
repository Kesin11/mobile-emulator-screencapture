require "test_helper"

class Mobile::Emulator::ScreencaptureTest < Minitest::Test
  def test_create_android
    android = Mobile::Emulator::Screencapture.create(platform: "android")

    assert android
  end

  def test_android_screenshot
    android = Mobile::Emulator::Screencapture.create(platform: "android", screenshot_dir: "./screenshot")

    assert android.screenshot("test")
  end

  def test_create_ios
    ios = Mobile::Emulator::Screencapture.create(platform: "ios")

    assert ios
  end
end

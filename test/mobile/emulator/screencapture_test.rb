require "test_helper"

class Mobile::Emulator::ScreencaptureTest < Minitest::Test
  def test_create_android
    android = Mobile::Emulator::Screencapture.create(platform: "android", hoge: "bar")

    assert android
  end

  def test_create_ios
    ios = Mobile::Emulator::Screencapture.create(platform: "ios", hoge: "bar")

    assert ios
  end
end

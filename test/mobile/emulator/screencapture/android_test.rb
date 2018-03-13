require "test_helper"

class Mobile::Emulator::Screencapture::AndroidTest < Minitest::Test
  def setup
    @android = Mobile::Emulator::Screencapture.create(
      platform: "android",
      screenshot_dir: "./screenshot"
    )
  end

  def test_screenshot
    @android.expects(:_native_screenshot)
    @android.expects(:_pull_screenshot)

    @android.screenshot("test_image")
  end
end

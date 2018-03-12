require 'mobile/emulator/screencapture/base'

module Mobile
  module Emulator
    module Screencapture
      class Android < Base
        DEVICE_SCREENSHOT_PATH = '/sdcard/screenshot.png'
        DEVICE_SCREENRECORD_PATH = '/sdcard/screenrecord.mp4'

        attr_reader :width, :height, :bit_rate, :time_limit
        def initialize(**args)
          super(args)
          @width = args[:width]
          @height = args[:height]
          @bit_rate = args[:bit_rate]
          @time_limit = args[:time_limit]
        end

        def screenshot(image_name)
          screenshot_path = File.join(@screenshot_dir, "#{image_name}.png")
          _native_screenshot
          _pull_screenshot(screenshot_path)

          screenshot_path
        end

        def _native_screenshot
          `adb shell screencap #{DEVICE_SCREENSHOT_PATH}`
        end

        def _pull_screenshot(screenshot_path)
          `adb pull #{DEVICE_SCREENSHOT_PATH} #{screenshot_path}`
          `adb shell rm #{DEVICE_SCREENSHOT_PATH}`
        end

        def start_screenrecord(video_name)
          screenrecord_path = File.join(@screenrecord_pid, "#{video_name}.mp4")
          screenrecord_path

          # handling pid
        end

        def _native_start_screenrecord
        end

        def stop_screenrecord
          # handling pid
        end

        def _native_stop_screenrecord
        end

        def pull_screenrecord
        end
      end
    end
  end
end

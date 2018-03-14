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

          @screenrecord_path = nil
        end

        def screenshot(image_name)
          screenshot_path = File.join(@screenshot_dir, "#{image_name}.png")
          _native_screenshot
          _pull_screenshot(screenshot_path)

          screenshot_path
        end

        def _adb(command)
          `adb #{command}`
        end

        def _native_screenshot
          _adb("shell screencap #{DEVICE_SCREENSHOT_PATH}")
        end

        def _pull_screenshot(screenshot_path)
          _adb("pull #{DEVICE_SCREENSHOT_PATH} #{screenshot_path}")
          _adb("adb shell rm #{DEVICE_SCREENSHOT_PATH}")
        end

        def start_screenrecord(video_name)
          raise "Screenrecord process already started. pid: #{@screenrecord_pid}" if @screenrecord_pid

          @screenrecord_path = File.join(@screenrecord_pid, "#{video_name}.mp4")
          @screenrecord_pid = _native_start_screenrecord

          @screenrecord_path
        end

          # TODO: add screen record option
        def _native_start_screenrecord
          pid = spwan("adb shell screenrecord #{DEVICE_SCREENRECORD_PATH}", out: '/dev/null')
          Process.detach(pid)
          pid
        end

        def stop_screenrecord
          raise 'Any screenrecord process did not started' unless @screenrecord_pid
          screenrecord_path = @screenrecord_path

          _native_stop_screenrecord
          _pull_screenrecord(screenrecord_path)

          @screenrecord_pid = nil
          @screenrecord_path = nil

          screenrecord_path
        end

        def _native_stop_screenrecord
          killed_process_num = Process.kill('SIGINT', @screenrecord_pid)
          raise "Kill pid: #{@screenrecord_pid} did not end correctly." unless killed_process_num.positive?

          # For ignore error when process already terminated.
          begin
            Process.waitpid(@pid)
          rescue Errno::ECHILD
          end
        end

        def _pull_screenrecord(screenrecord_path)
          _adb("pull #{DEVICE_SCREENRECORD_PATH} #{screenrecord_path}")
          _adb("shell rm #{DEVICE_SCREENRECORD_PATH}")
        end
      end
    end
  end
end

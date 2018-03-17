require 'mobile/emulator/screencapture/base'

module Mobile
  module Emulator
    module Screencapture
      class Android < Base
        DEVICE_SCREENSHOT_PATH = '/sdcard/screenshot.png'.freeze
        DEVICE_SCREENRECORD_PATH = '/sdcard/screenrecord.mp4'.freeze

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
          raise "Argument image_name is nil" if image_name.nil?

          screenshot_path = File.join(@screenshot_dir, "#{image_name}.png")
          _native_screenshot
          _pull_screenshot(screenshot_path)

          screenshot_path
        end

        def _adb(command)
          `adb #{command}`
        end

        def _adb_spawn(command)
          pid = spawn("adb #{command}", out: '/dev/null')
          Process.detach(pid)
          pid
        end

        def _native_screenshot
          _adb("shell screencap #{DEVICE_SCREENSHOT_PATH}")
        end

        def _pull_screenshot(screenshot_path)
          _adb("pull #{DEVICE_SCREENSHOT_PATH} #{screenshot_path}")
          _adb("shell rm #{DEVICE_SCREENSHOT_PATH}")
        end

        def start_screenrecord(video_name)
          raise "Argument video_name is nil" if video_name.nil?
          raise "Screenrecord process already started. pid: #{@screenrecord_pid}" if @screenrecord_pid

          @screenrecord_path = File.join(@screenrecord_dir, "#{video_name}.mp4")
          @screenrecord_pid = _native_start_screenrecord

          @screenrecord_path
        end

        def _native_start_screenrecord
          command = ["shell screenrecord #{DEVICE_SCREENRECORD_PATH}"]
          command << "--size #{@width}x#{@height}" if @width && @height
          command << "--bit-rate #{@bit_rate}" if @bit_rate
          command << "--time-limit #{@time_limit}" if @time_limit
          _adb_spawn(command.join(' '))
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

          # If 'adb pull' after kill recording process soon, the video will be broken.
          sleep 2
        end

        def _pull_screenrecord(screenrecord_path)
          _adb("pull #{DEVICE_SCREENRECORD_PATH} #{screenrecord_path}")
          _adb("shell rm #{DEVICE_SCREENRECORD_PATH}")
        end
      end
    end
  end
end

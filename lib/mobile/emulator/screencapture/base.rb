require 'fileutils'

module Mobile
  module Emulator
    module Screencapture
      class Base
        attr_reader :screenshot_dir, :screenrecord_dir
        def initialize(**args)
          @screenshot_dir = args[:screenshot_dir] || Bundler.root
          @screenrecord_dir = args[:screenrecord_dir] || Bundler.root

          @screenrecord_pid = nil

          FileUtils.mkdir_p(@screenshot_dir)
          FileUtils.mkdir_p(@screenrecord_dir)
        end
      end
    end
  end
end

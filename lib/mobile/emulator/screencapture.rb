require "mobile/emulator/screencapture/version"
require "mobile/emulator/screencapture/android"
require "mobile/emulator/screencapture/ios"

module Mobile
  module Emulator
    module Screencapture
      class << self
        def create(**args)
          if args[:platform] == "android"
            Mobile::Emulator::Screencapture::Android.new(args)
          elsif args[:platform] == "ios"
            Mobile::Emulator::Screencapture::Ios.new(args)
          else
            raise "Not support platform: #{args[:platform]}"
          end
        end
      end
    end
  end
end

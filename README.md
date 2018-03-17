# Mobile::Emulator::Screencapture
[![Gem Version](https://badge.fury.io/rb/mobile-emulator-screencapture.svg)](https://badge.fury.io/rb/mobile-emulator-screencapture)
[![Build Status](https://travis-ci.org/Kesin11/mobile-emulator-screencapture.svg?branch=master)](https://travis-ci.org/Kesin11/mobile-emulator-screencapture)

Ruby wrapper for take screenshot and screenrecord on ios/android emulators.

## How to work
### Android
Using `adb screencap` and `adb screenrecord`  
see: https://developer.android.com/studio/command-line/adb.html

`adb screenrcord` is only supported: Android >= 4.4（API Level 19）

### iOS
**Not supported yet**

Using `xcrun simctl io screenshot` and `xcrun simctl io recordVideo`

see: `xcrun simctl io --help`

`xcrun simctl io screenshot` is only supported: Xcode >= 8.2

## Installation

```ruby
gem 'mobile-emulator-screencapture'
```

## Usage
### Android

```ruby
require 'mobile/emulator/screencapture'

android = Mobile::Emulator::Screencapture.create(
  platform: "android",
  screenshot_dir: "./screenshot",
  screenrecord_dir: "./screenrecord",

  # options for adb screenrecord
  width: 720,
  height: 360
  bit_rate: 6_000_000,
  time_limit: 180
)

android.screenshot("test")
# > ./screenshot/test.png

android.start_screenrecord("test")
sleep 30
android.stop_screenrecord
# > ./screenrecord/test.mp4
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Kesin11/mobile-emulator-screencapture.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

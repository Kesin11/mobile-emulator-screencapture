
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mobile/emulator/screencapture/version"

Gem::Specification.new do |spec|
  spec.name          = "mobile-emulator-screencapture"
  spec.version       = Mobile::Emulator::Screencapture::VERSION
  spec.authors       = ["Kenta Kase"]
  spec.email         = ["kesin1202000@gmail.com"]

  spec.summary       = 'Ruby wrapper for ios/android screen capture'
  spec.description   = 'Ruby wrapper for ios/android screen capture using simctl/adb screenshot/screenrecord.'
  spec.homepage      = "https://github.com/Kesin11/mobile-emulator-screencapture"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop"
end

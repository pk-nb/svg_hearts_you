# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'svg_hearts_you/version'

Gem::Specification.new do |spec|
  spec.name          = "svg_hearts_you"
  spec.version       = SvgHeartsYou::VERSION
  spec.authors       = ["Nathanael Beisiegel"]
  spec.email         = ["pknb.dev@gmail.com"]
  spec.summary       = %q{A heartwarming gem to inline SVG. Inline or symbolize and use. Easy.}
  spec.description   = %q{A heartwarming gem to inline SVG. SVG Hearts You provides helper
                          methods to inline SVG. You can directly inline for maximum CSS control,
                          or symbolize a file or folder of SVGs and reuse the symbols. }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.test_files = Dir["spec/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
  # spec.add_runtime_dependency 'activesupport'
  # spec.add_runtime_dependency 'actionpack'

  spec.add_development_dependency 'rails', '~> 4'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-html-matchers'
  spec.add_development_dependency 'pry'

  # Rails Dummy Dependencies
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'launchy'
  spec.add_development_dependency 'factory_girl_rails'
  spec.add_development_dependency 'slim'
  spec.add_development_dependency 'slim-rails'

  # Middleman Dummy Dependencies
  spec.add_development_dependency 'middleman'
end

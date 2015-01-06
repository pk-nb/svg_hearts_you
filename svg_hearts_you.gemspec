# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'svg_hearts_you/version'

Gem::Specification.new do |spec|
  spec.name          = 'svg_hearts_you'
  spec.version       = SvgHeartsYou::VERSION
  spec.authors       = ['Nathanael Beisiegel']
  spec.email         = ['pknb.dev@gmail.com']
  spec.summary       = %q{A heartwarming gem to inline SVG. Inline or symbolize and use. Easy.}
  spec.description   = %q{A heartwarming gem to inline SVG. SVG Hearts You provides helper
                          methods to inline SVG. You can directly inline for maximum CSS control,
                          or symbolize a file or folder of SVGs and reuse the symbols. }
  spec.homepage      = 'https://github.com/pk-nb/svg_hearts_you'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = `git ls-files -- {features,fixtures,spec}/*`.split($/)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri', '~> 1.6'

  spec.add_development_dependency 'rails', '~> 4'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'rspec-html-matchers', '~> 0.6'
  spec.add_development_dependency 'pry', '~> 0.10'

  # Middleman Test Dummy Dependencies
  spec.add_development_dependency 'middleman-core', '~> 3.2'
  spec.add_development_dependency 'sprockets', '~> 2.12'
  spec.add_development_dependency 'cucumber',  '~> 1.3'
  spec.add_development_dependency 'aruba',     '~> 0.6'
  spec.add_development_dependency 'coveralls', '~> 0.7'

  # Rails Dummy Dependencies
  spec.add_development_dependency 'sqlite3', '~> 1.3'
  spec.add_development_dependency 'rspec-rails', '~> 3.1'
  spec.add_development_dependency 'capybara', '~> 2.4'
  spec.add_development_dependency 'launchy', '~> 2.4'
  spec.add_development_dependency 'factory_girl_rails', '~> 4.4'
end

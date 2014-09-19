# require 'bundler/setup'
# Bundler.setup

require 'svg_hearts_you'
require 'rspec-html-matchers'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
end

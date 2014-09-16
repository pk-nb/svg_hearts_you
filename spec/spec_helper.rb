# require 'bundler/setup'
# Bundler.setup

require 'svg_hearts_you'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"
end

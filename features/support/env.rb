ENV["TEST"] = "true"

PROJECT_ROOT_PATH = File.dirname(File.dirname(File.dirname(__FILE__)))
require 'middleman-core'
require 'middleman-core/step_definitions'
require 'capybara'

# require 'codeclimate-test-reporter'
# CodeClimate::TestReporter.start

# Capybara.configure do |config|
#   config.save_and_open_page_path = 'tmp/capybara'
# end

require File.join(PROJECT_ROOT_PATH, 'lib', 'svg_hearts_you')

begin
  require "pry"
rescue LoadError
end

require 'svg_hearts_you/configuration'
require 'svg_hearts_you/module'
require 'svg_hearts_you/helpers'

require 'svg_hearts_you/railtie' if defined?(Rails)
require 'svg_hearts_you/middleman_extension' if defined?(Middleman)

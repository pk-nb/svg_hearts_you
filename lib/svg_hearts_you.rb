require 'nokogiri'

begin
  require 'pry'
rescue LoadError
end

require 'svg_hearts_you/configuration'

module SvgHeartsYou
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def svg_inline(filename, options={})
    raise 'svg_path is not set' if self.configuration.nil?

    file = File.read(Configuration.new)
  end

  def svg_symbol
    raise 'svg_path is not set' if self.configuration.nil?
  end

  def svg_use
    raise 'svg_path is not set' if self.configuration.nil?
  end
end

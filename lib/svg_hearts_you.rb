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

  def svg_inline(file)

  end

  def svg_symbol

  end

  def svg_use

  end
end

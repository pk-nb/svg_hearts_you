require 'nokogiri'
# require 'rails'
# require 'action_view'

begin
  require "pry"
rescue LoadError
end

module SvgHeartsYou
  class << self
    attr_accessor :configuration
  end

  # Allow a persistent configuration object to be set on the module
  def self.configure
    yield(configuration)
  end

  private
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end
end

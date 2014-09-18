require 'nokogiri'

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

  def SvgHeartsYou.svg_inline(filename, options={})
    raise 'svg_path is not set' if configuration.svg_path.nil?

    path = File.join configuration.svg_path, filename

    doc = Nokogiri::HTML::DocumentFragment.parse(File.read path)
    svg = doc.at_css 'svg'
    options.each do |key, value|
      svg[key.to_s] = value
    end

    svg.to_html
  end

  def SvgHeartsYou.svg_symbol
    raise 'svg_path is not set' if configuration.nil?
  end

  def SvgHeartsYou.svg_use
    raise 'svg_path is not set' if configuration.nil?
  end
end

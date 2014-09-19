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

  def self.svg_inline(filename, options={})
    raise 'svg_path is not set' if configuration.svg_path.nil?

    path = File.join configuration.svg_path, filename
    doc = Nokogiri::HTML::DocumentFragment.parse(File.read path)
    svg = doc.at_css 'svg'
    options.each do |key, value|
      svg[key.to_s] = value
    end

    svg.to_html
  end

  def self.svg_symbol
    raise 'svg_path is not set' if configuration.svg_path.nil?
    #
    # path = File.join configuration.svg_path, filename
    # doc = Nokogiri::HTML::DocumentFragment.parse(File.read path)
    #
    # svg = doc.at_css 'svg'

  end

  def self.svg_use(id, options={})
    doc = Nokogiri::HTML::DocumentFragment.parse <<-YAYUSE
    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" >
      <use xlink:href="##{id}">
    </svg>
    YAYUSE

    svg = doc.at_css 'svg'
    options.each do |key, value|
      svg[key.to_s] = value
    end

    svg.to_html
  end
end

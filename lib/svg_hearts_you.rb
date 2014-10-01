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

  def self.svg_symbol(filename, options={})
    raise 'svg_path is not set' if configuration.svg_path.nil?

    path = File.join configuration.svg_path, filename
    doc = Nokogiri::HTML::DocumentFragment.parse(File.read path)

    original_svg = doc.at_css 'svg'
    new_svg = Nokogiri::XML::Node.new 'svg', doc

    # Change original svg to a symbol and set id to the filename
    original_svg.name = 'symbol'
    original_svg['id'] = filename.chomp('.svg')

    # Move the SVG specific attributes to outer svg
    ['version', 'xmlns', 'xmlns:xlink'].map do |attr|
      new_svg[attr] = original_svg.delete attr
    end

    # original_svg.parent = new_svg
    new_svg.add_child(original_svg)

    options.each do |key, value|
      new_svg[key.to_s] = value
    end

    new_svg.to_html
  end

  def self.svg_use(id, options={})
    doc = Nokogiri::HTML::DocumentFragment.parse <<-YAYUSE
    <svg version="1.1" xmlns="http://www.w3.org/2000/svg">
      <use xlink:href="##{id}">
    </svg>
    YAYUSE

    svg = doc.at_css 'svg'

    options.delete :title
    options.delete :desc

    options.each do |key, value|
      svg[key.to_s] = value
    end

    svg.to_html
  end
end

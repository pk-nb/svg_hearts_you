require 'nokogiri'

module SvgHeartsYou
  class << self
    attr_accessor :configuration
  end

  # Allow a persistent configuration object to be set on the module
  def self.configure
    yield(configuration)
  end

  def self.svg_inline(filename, options={})
    validate_configuration

    doc = Nokogiri::HTML::DocumentFragment.parse(read_file filename)
    svg = doc.at_css 'svg'

    # Attributes are added after
    options.each do |key, value|
      svg[key.to_s] = value
    end

    svg.to_html
  end

  def self.svg_symbol(filename, options={})
    validate_configuration

    doc = Nokogiri::HTML::DocumentFragment.parse(read_file filename)

    # Create two nodes for the symbol. The original svg tag will turn into
    # a symbol tag, and the new tag will enclose it.
    original_svg = doc.at_css 'svg'
    new_svg = Nokogiri::XML::Node.new 'svg', doc

    # Change original svg to a symbol and set id to the filename
    original_svg.name = 'symbol'
    original_svg['id'] = filename.chomp('.svg')

    # Move the SVG specific attributes to outer svg and then wrap
    %w(version xmlns xmlns:xlink).map do |attr|
      new_svg[attr] = original_svg.delete attr
    end

    # Wrap old svg-now-symbol in new svg tag
    new_svg.add_child(original_svg)

    # Any extra attributes go on the svg tag
    options.each do |key, value|
      new_svg[key.to_s] = value
    end

    new_svg.to_html
  end

  def self.svg_use(id, options={})
    doc = Nokogiri::HTML::DocumentFragment.parse <<-YAYUSE
    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <use xlink:href="##{id}">
    </svg>
    YAYUSE

    svg = doc.at_css 'svg'

    # TODO allow for the title and desc stuff
    options.delete :title
    options.delete :desc

    options.each do |key, value|
      svg[key.to_s] = value
    end

    svg.to_html
  end

  private
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.validate_configuration
    raise 'svg_path is not set' if configuration.svg_path.nil?
  end

  def self.read_file(filename)
    path = File.join configuration.svg_path, filename
    raise "File #{filename} not found" unless File.exists?(path)
    File.read path
  end
end

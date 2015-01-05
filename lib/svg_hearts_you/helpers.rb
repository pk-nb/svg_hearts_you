require 'nokogiri'

module SvgHeartsYou

  # def self.read_file(filename)
  #   path = File.join configuration.svg_path, filename
  #   raise "File #{filename} not found" unless File.exists?(path)
  #   File.read path
  # end

  def self.find_svg_file(filename)
    configuration.all_svg_paths.each do |path|
      file_path = File.join path, filename
      if File.exists?(file_path)
        return File.read file_path
      end
    end

    # if not found, raise error
    raise "File #{filename} not found"
  end

  def self.svgs_for_folder(folder_name)
    configuration.all_svg_paths.each do |path|
      folder_path = File.join path, folder_name
      if File.exists?(folder_path) && File.directory?(folder_path)
        Dir.chdir(folder_path)
        return Dir.glob("*.svg*").map do |filename|
          file_path = File.join folder_path, filename
          { file: File.read(file_path), filename: filename }
          # File.join(folder_name, filename)
        end
      end
    end

    # if not found, raise error
    raise "Folder #{folder_name} not found"
  end


  module Helpers

    def svg_inline(filename, options={})
      svg_file = SvgHeartsYou::find_svg_file(filename)

      doc = Nokogiri::HTML::DocumentFragment.parse(svg_file)
      svg = doc.at_css 'svg'

      # Attributes are added after
      options.each do |key, value|
        svg[key.to_s] = value
      end

      svg.to_html.html_safe
    end

    def svg_symbol(filename, options={})
      folder_mode = options.delete(:folder)

      if folder_mode
        folders = [*filename]
        read_files = []

        folders.each do |folder_name|
          read_files += SvgHeartsYou::svgs_for_folder(folder_name)
        end

        symbols = read_files.map do |file|
          doc = Nokogiri::HTML::DocumentFragment.parse(file[:file])
          { node: doc.at_css('svg'), filename: file[:filename] }
        end
      else
        files = [*filename]
        symbols = files.map do |file|
          svg_file = SvgHeartsYou::find_svg_file(file)
          doc = Nokogiri::HTML::DocumentFragment.parse(svg_file)
          { node: doc.at_css('svg'), filename: file }
        end
      end



      doc = Nokogiri::HTML::DocumentFragment.parse('')
      wrapper_svg = Nokogiri::XML::Node.new 'svg', doc

      wrapper_svg['xmlns'] = 'http://www.w3.org/2000/svg'
      wrapper_svg['style'] = 'display: none;'

      symbols.each do |symbol|
        node = symbol[:node]

        # Convert
        node.name = 'symbol'
        node['id'] = symbol[:filename].chomp('.svg')

        # add `each` items here
        if options[:each]
          options[:each].each do |key, value|
            node[key.to_s] = value
          end
        end

        %w(version xmlns xmlns:xlink).each do |attr|
          node.delete attr
        end

        # yield here to block?


        wrapper_svg.add_child(node)
      end

      options.delete(:each)

      # Put remaining options on parent svg tag
      options.each do |key, value|
        wrapper_svg[key.to_s] = value
      end


      # validate_configuration
      # svg_file = SvgHeartsYou::find_svg_file(filename)
      #
      # doc = Nokogiri::HTML::DocumentFragment.parse(svg_file)
      #
      # # Create two nodes for the symbol. The original svg tag will turn into
      # # a symbol tag, and the new tag will enclose it.
      # original_svg = doc.at_css 'svg'
      # new_svg = Nokogiri::XML::Node.new 'svg', doc
      #
      # # Change original svg to a symbol and set id to the filename
      # original_svg.name = 'symbol'
      # original_svg['id'] = filename.chomp('.svg')
      #
      # # Add all attributes to symbol
      # options.each do |key, value|
      #   original_svg[key.to_s] = value
      # end
      #
      # # Move the SVG specific attributes to outer svg and then wrap
      # %w(version xmlns xmlns:xlink).map do |attr|
      #   new_svg[attr] = original_svg.delete attr
      # end
      #
      # # Wrap old svg-now-symbol in new svg tag
      # new_svg.add_child(original_svg)

      wrapper_svg.to_html.html_safe
    end

    def svg_use(id, options={})
      # Strip .svg extension if necessary
      id.gsub!(/\.svg\z/, '')

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

      svg.to_html.html_safe
    end
  end

  # Add helpers as class methods on the SvgHeartsYou module
  class << self
    include Helpers
  end
end

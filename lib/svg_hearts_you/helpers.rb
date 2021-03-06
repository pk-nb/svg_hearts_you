require 'nokogiri'

module SvgHeartsYou

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
      # Add .svg extension if missing
      filename += '.svg' unless filename.end_with?('.svg')

      svg_file = SvgHeartsYou::find_svg_file(filename)

      doc = Nokogiri::HTML::DocumentFragment.parse(svg_file)
      svg = doc.at_css 'svg'

      # Attributes are added after
      options.each do |key, value|
        svg[key.to_s] = value
      end

      stringify(svg)
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

      wrapper_svg['version'] = '1.1'
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

        if block_given?
          attributes = {}
          node.entries.each do |item|
            attributes[item[0].to_sym] = item[1]
          end

          # Allow each symbol to be configured if block given
          yield(attributes)

          attributes.each do |key, value|
            node[key.to_s] = value
          end
        end

        wrapper_svg.add_child(node)
      end

      options.delete(:each)

      # Put remaining options on parent svg tag
      options.each do |key, value|
        wrapper_svg[key.to_s] = value
      end

      stringify(wrapper_svg)
    end

    def svg_use(id, options={})
      # Strip .svg extension if necessary
      id.gsub!(/\.svg\z/, '')

      # Add hash symbol to beginning if necessary
      id = '#' + id unless id.include?('#')

      doc = Nokogiri::HTML::DocumentFragment.parse <<-YAYUSE
      <svg version="1.1" xmlns="http://www.w3.org/2000/svg">
        <use xlink:href="#{id}">
      </svg>
      YAYUSE

      svg = doc.at_css 'svg'

      # TODO allow for the title and desc stuff
      options.delete :title
      options.delete :desc

      options.each do |key, value|
        svg[key.to_s] = value
      end

      stringify(svg)
    end

    private
    def stringify(node)
      str = node.to_html
      str = str.html_safe if str.respond_to? :html_safe
      str
    end
  end

  # Add helpers as class methods on the SvgHeartsYou module
  class << self
    include Helpers
  end
end

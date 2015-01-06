require 'spec_helper'

RSpec.describe SvgHeartsYou do

  let(:test_svg_path)          { File.join File.dirname(__FILE__), 'svgs' }
  let!(:svg_file)              { 'sapphire.svg' }
  let!(:svg_file2)             { 'circle.svg' }
  let!(:svg_folder)            { 'shapes' }
  let!(:svg_folder2)           { 'logos' }
  let!(:nonexistent_svg_file)  { 'nope-nope.svg' }

  let!(:unconfigured_message)  { "File #{svg_file} not found" }
  let!(:missing_file_message)  { "File #{nonexistent_svg_file} not found" }


  # Singleton module is messy for random order tests, so wipe state after each
  after(:each) do
    SvgHeartsYou.reset
  end

  # Generically tests methods (passed as symbol) that are
  # expected to throw runtime errors
  shared_examples 'methods that throw error on file not found' do |method|
    it 'throws a RuntimeError when not file not found' do
      expect{subject.send(method, svg_file)}.to raise_error(RuntimeError, unconfigured_message)
    end
  end

  # Examples for methods that may throw error when files are missing
  shared_examples 'method using file' do |method|
    it 'throws a RuntimeError when file is not found' do
      expect{subject.send(method, nonexistent_svg_file)}.to raise_error(RuntimeError, missing_file_message)
    end
  end

  # Tests that are used in both unconfigured and configured contexts
  shared_examples 'svg use' do
    it 'returns SVG use statement' do
      svg_content = subject.svg_use '#id'
      expect(svg_content).to include '<use xlink:href="#id">'
    end

    it 'adds hash at beginning if not given or external link' do
      svg_content = subject.svg_use 'id'
      expect(svg_content).to include '<use xlink:href="#id">'
    end

    it 'adds classes and ids to svg tag' do
      svg_content = subject.svg_use '#id', id: 'hearts', class: 'love'
      expect(svg_content).to have_tag('svg', with: { id: 'hearts', class: 'love' })
    end

    it 'adds any attribute to svg tag' do
      attributes = { width: '64px', height: '48px', viewport: '0, 0, 12, 24' }
      svg_content = subject.svg_use '#id', attributes
      expect(svg_content).to have_tag('svg', with: attributes)
    end

    it 'strips .svg extension if necessary' do
      svg_content = subject.svg_use '#circle.svg'
      expect(svg_content).to include '<use xlink:href="#circle">'
      expect(svg_content).to_not include '<use xlink:href="#circle.svg">'
    end
  end


  describe 'without configuration' do
    describe 'self.configuration' do
      it 'defaults attributes to nil' do
        expect(SvgHeartsYou.configuration.svg_paths).to eq([])
      end
    end

    describe '#svg_inline' do
      it_behaves_like 'methods that throw error on file not found', :svg_inline
    end

    describe '#svg_use' do
      include_examples 'svg use'
    end

    describe '#svg_symbol' do
      it_behaves_like 'methods that throw error on file not found', :svg_symbol
    end
  end

  describe 'with configuration' do
    before do
      SvgHeartsYou.configure do |config|
        config.svg_paths << test_svg_path
      end
    end

    describe 'self.configuration' do
      it 'is configured to the the current directory' do
        expect(SvgHeartsYou.configuration.svg_paths).to eq([test_svg_path])
      end
    end

    describe '#svg_inline' do
      it_behaves_like 'method using file', :svg_inline

      it 'returns contents of SVG file without XML headers' do
        svg_content = subject.svg_inline 'sapphire.svg'

        expect(svg_content).to have_tag('svg')
        expect(svg_content).not_to include('<xml')
        expect(svg_content).not_to include('DOCTYPE')
      end

      it 'can be called without the .svg extension' do
        svg_content = subject.svg_inline 'sapphire'
        expect(svg_content).to have_tag('svg')
      end
    end

    describe '#svg_use' do
      include_examples 'svg use'
    end

    describe '#svg_symbol' do
      let(:sapphire_svg_attributes) {{
        x: '0',
        y: '0',
        width: '64',
        height: '52',
        viewbox: '0, 0, 64, 52'
        }}

      it_behaves_like 'method using file', :svg_symbol

      it 'returns the SVG contents in a symbol' do
        svg_content = subject.svg_symbol svg_file

        expect(svg_content).not_to have_tag('svg', with: sapphire_svg_attributes)
        expect(svg_content).to have_tag('svg>symbol', with: sapphire_svg_attributes)
        expect(svg_content).to have_tag('svg>symbol', with: { id: 'sapphire' })
        expect(svg_content).not_to have_tag('svg>*:not(symbol)')
        expect(svg_content).to have_tag('svg>symbol>*')
      end

      it 'applies extra attributes to top level svg' do
        new_id = 'hey-there'

        svg_content = subject.svg_symbol svg_file, id: new_id
        expect(svg_content).to have_tag('svg', with: {id: new_id})
      end

      it 'applies or replaces attributes on each symbol with the `each` parameter' do
        new_viewbox = '0, 0, 100, 100'
        new_class = 'shape'

        updated_attributes = sapphire_svg_attributes.clone
        updated_attributes[:viewbox] = new_viewbox
        updated_attributes[:class] = new_class

        svg_content = subject.svg_symbol svg_file, each: { viewbox: new_viewbox, class: new_class }
        expect(svg_content).to have_tag('svg>symbol', with: updated_attributes)
      end

      it 'pulls in multiple files' do
        svg_content = subject.svg_symbol [svg_file, svg_file2]
        expect(svg_content).to have_tag('svg>symbol', count: 2)
      end

      it 'pulls in a given folder with `folder` parameter' do
        svg_content = subject.svg_symbol svg_folder, folder: true
        expect(svg_content).to have_tag('svg>symbol', with: { id: 'polygon' })
        expect(svg_content).to have_tag('svg>symbol', with: { id: 'star' })
        expect(svg_content).to have_tag('svg>symbol', with: { id: 'triangle' })
      end

      it 'pulls in multiple folders with `folder` parameter' do
        svg_content = subject.svg_symbol [svg_folder, svg_folder2], folder: true
        expect(svg_content).to have_tag('svg>symbol', count: 8)
      end

      it 'takes a block that can modify each symbol' do
        new_class = 'shape'

        svg_content = subject.svg_symbol svg_folder, folder: true do |attributes|
          attributes[:id] = attributes[:id] + '-extra'
          attributes[:class] = 'shape'
        end

        expect(svg_content).to have_tag('svg>symbol', with: { id: 'polygon-extra',  class: new_class })
        expect(svg_content).to have_tag('svg>symbol', with: { id: 'star-extra',     class: new_class })
        expect(svg_content).to have_tag('svg>symbol', with: { id: 'triangle-extra', class: new_class })
      end
    end
  end

  # Meta test to make sure state is wiped
  it 'correctly resets configuration at end of tests' do
    expect(SvgHeartsYou.configuration.svg_paths).to eq([])
  end
end

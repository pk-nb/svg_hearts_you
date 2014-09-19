require 'spec_helper'

RSpec.describe SvgHeartsYou do

  let(:test_svg_path) { File.join(File.dirname(__FILE__), 'svgs') }

  describe 'module not configured' do
    describe 'self.configuration' do
      it 'not configured' do
        expect(SvgHeartsYou.configuration.svg_path).to be_nil
      end
    end

    describe '#svg_inline' do
      it 'raises RuntimeError' do
        expect{subject.svg_inline('sapphire.svg')}.to raise_error(RuntimeError)
      end
    end

    describe '#svg_use' do
      it 'returns SVG use statement' do
        svg_content = subject.svg_use 'id'
        expect(svg_content).to include '<use xlink:href="#id">'
      end

      it 'adds classes and ids to svg tag' do
        svg_content = subject.svg_use 'id', id: 'hearts', class: 'love'
        expect(svg_content).to include 'id="hearts" class="love"'
      end

      it 'adds any attribute to svg tag' do
        svg_content = subject.svg_use 'id', width: '64px', height: '48px', viewport: '0, 0, 12, 24'
        expect(svg_content).to include 'width="64px" height="48px" viewport="0, 0, 12, 24"'
      end
    end
  end


  describe 'module configured' do
    before do
      SvgHeartsYou.configure do |config|
        config.svg_path = test_svg_path
      end
    end

    describe 'self.configuration' do
      it 'is configured to the the current directory' do
        expect(SvgHeartsYou.configuration.svg_path).to eq(test_svg_path)
      end
    end

    describe '#svg_inline' do
      it 'returns contents of SVG file without XML headers' do
        svg_content = subject.svg_inline 'sapphire.svg'
        expect(svg_content).to include('<svg')
        expect(svg_content).to include('sapphire')
        expect(svg_content).not_to include('<xml')
        expect(svg_content).not_to include('DOCTYPE')
      end
    end

    describe '#svg_symbol' do
      it 'returns the SVG contents in a symbol' do
        svg_content = subject.svg_symbol 'sapphire.svg'

        sapphire_svg_attributes = {
          x: '0',
          y: '0',
          width: '64',
          height: '52',
          viewbox: '0, 0, 64, 52'
        }

        expect(svg_content).not_to have_tag('svg', with: sapphire_svg_attributes)
        expect(svg_content).to have_tag('svg>symbol', with: sapphire_svg_attributes)
        expect(svg_content).not_to have_tag('svg>*:not(symbol)')
        expect(svg_content).to have_tag('svg>symbol>*')
      end
    end
  end
end

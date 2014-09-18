require 'spec_helper'

RSpec.describe SvgHeartsYou do

  let(:test_svg_path) { File.join(File.dirname(__FILE__), 'svgs') }

  describe 'module not configured' do
    describe 'self.configuration' do
      it 'not configured' do
        expect(SvgHeartsYou.configuration.svg_path).to be_nil
      end
    end

    it 'raises RuntimeError' do
      expect{subject.svg_inline('sapphire.svg')}.to raise_error(RuntimeError)
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
      it 'returns SVG' do
        svg_content = subject.svg_inline('sapphire.svg')
        expect(svg_content).to include('<svg')
        expect(svg_content).to include('sapphire')
        expect(svg_content).not_to include('<xml')
      end
    end
  end
end

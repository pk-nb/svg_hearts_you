require 'spec_helper'

module SvgHeartsYou
  describe Configuration do
    describe '#svg_path' do

      it 'has a default value of nil' do
        expect(Configuration.new.svg_paths).to eq([])
      end

      it 'can set the svg_path' do
        config = Configuration.new
        config.svg_paths << '/some/path';
        expect(config.svg_paths).to eq(['/some/path'])
      end
    end
  end
end

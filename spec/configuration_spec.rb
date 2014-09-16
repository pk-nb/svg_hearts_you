require 'spec_helper'

module SvgHeartsYou
  describe Configuration do
    describe '#svg_path' do

      it 'has a default value of nil' do
        expect(Configuration.new.svg_path).to be_nil
      end

      it 'can set the svg_path' do
        config = Configuration.new
        config.svg_path = '/some/path';
        expect(config.svg_path).to eq('/some/path')
      end
    end
  end
end

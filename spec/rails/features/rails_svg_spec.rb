require 'spec_helper'

RSpec.describe 'SvgHeartsYou for Rails:', type: :feature do

  let(:test_svg_path) { 'some/junk/path/svgs' }


  describe 'configuration' do
    describe 'paths searched' do
      # Singleton module is messy for random order tests, so wipe state after each
      after(:each) do
        SvgHeartsYou.reset
      end

      it 'includes rails assets path' do
        expect(SvgHeartsYou.configuration.all_svg_paths.length).to be > 0
      end

      it 'uses internal svg_paths before rails assets paths' do
        SvgHeartsYou.configure do |config|
          config.svg_paths << test_svg_path
        end

        expect(SvgHeartsYou.configuration.all_svg_paths[0]).to be(test_svg_path)
      end
    end
  end

  describe 'the svg method' do
    before do
      visit '/basic'
    end

    it '#svg_inline' do
      expect(page).to have_selector('path')
    end

    it '#svg_symbol' do
      expect(page).to have_selector('symbol')
    end

    it '#svg_use' do
      expect(page).to have_selector('use')
      # save_and_open_page
    end
  end
end

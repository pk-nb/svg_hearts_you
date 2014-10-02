require 'spec_helper'

RSpec.describe 'SvgHeartsYou for Rails:', type: :feature do

  describe 'configuration' do
    it 'is set by to `app/assets/images/svg` by default'
  end

  describe 'the svg method' do
    before do
      visit '/basic'
    end


    it '#svg_inline' do
      expect(page).to have_selector('path')
    end

    it '#svg_symbol'

    it '#svg_use'
  end


end

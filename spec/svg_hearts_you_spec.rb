require 'spec_helper'

RSpec.describe SvgHeartsYou do
  before do
    SvgHeartsYou.configure do |config|
      config.svg_path = File.dirname(__FILE__)
    end
  end

  it 'is configured to the the current directory' do
    expect(SvgHeartsYou.configuration.svg_path).to eq(File.dirname(__FILE__))
  end

end

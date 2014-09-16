require 'spec_helper'

RSpec.describe SvgHeartsYou do
  let(:test_svg_path) { File.join(File.dirname(__FILE__), 'svgs') }

  before do
    SvgHeartsYou.configure do |config|
      config.svg_path = test_svg_path
    end
  end

  it 'is configured to the the current directory' do
    expect(SvgHeartsYou.configuration.svg_path).to eq(test_svg_path)
  end
end

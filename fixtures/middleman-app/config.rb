activate :svg_hearts_you

SvgHeartsYou.configure do |config|
  # binding.pry
  config.svg_paths << File.join(PROJECT_ROOT_PATH, 'fixtures', 'middleman-app', 'source')
end

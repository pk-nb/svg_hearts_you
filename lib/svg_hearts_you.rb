require 'svg_hearts_you/configuration'
require 'svg_hearts_you/module'
require 'svg_hearts_you/helpers'

# Bind to Rails, Middleman, Jeykll, Sinatra... if availible
ActionView::Base.send :include, SvgHeartsYou::Helpers if defined?(Rails)

if defined?(Middleman)
  # Middleman.helpers SvgHeartsYou::Helpers
end

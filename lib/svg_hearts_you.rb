require 'svg_hearts_you/configuration'
require 'svg_hearts_you/module'

# Bind to Rails, Middleman, Jeykll, Sinatra... if availible
ActionView::Base.send :include, SvgHeartsYou if defined?(Rails)

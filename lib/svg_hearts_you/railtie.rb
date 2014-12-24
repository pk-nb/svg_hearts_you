module SvgHeartsYou
  class Railtie < Rails::Railtie
    initializer 'SvgHeartsYou.add_helpers' do
      # ActiveSupport.on_load( :action_view ){ include SvgHeartsYou::Helpers }
      ActionView::Base.send :include, SvgHeartsYou::Helpers
    end
  end
end

module SvgHeartsYou
  module Extensions
    class Railtie < ::Rails::Railtie
      initializer 'SvgHeartsYou.add_helpers' do
        ActionView::Base.send :include, SvgHeartsYou::Helpers
      end
    end
  end
end

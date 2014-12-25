module SvgHeartsYou
  module Extensions
    class MiddlemanExtension < Middleman::Extension
      helpers do
        include SvgHeartsYou::Helpers
      end
    end
  end
end

::Middleman::Extensions.register(:svg_hearts_you, SvgHeartsYou::Extensions::MiddlemanExtension)

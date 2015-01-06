module SvgHeartsYou
  class Configuration
    attr_accessor :svg_paths

    def initialize
      @svg_paths = []
    end

    # Include asset paths / image_paths with rails / middleman
    def all_svg_paths
      if defined?(Rails)
        @svg_paths + rails_paths
      else
        @svg_paths
      end
    end

    private
    def rails_paths
      Rails.application.config.assets.paths
    end
  end
end

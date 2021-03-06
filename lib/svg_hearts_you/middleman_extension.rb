module SvgHeartsYou
  module Extensions
    class MiddlemanExtension < Middleman::Extension
      option :svg_paths, [], 'Used to set custom search path for SvgHeartsYou gem'

      def initialize(app, options_hash={}, &block)
        super

        # Configure gem if svg_paths option is set via middleman
        if options_hash.key?(:svg_paths)
          SvgHeartsYou.configure do |config|
            config.svg_paths << options_hash[:svg_paths]
          end
        end
      end

      helpers do
        include SvgHeartsYou::Helpers
      end

      def after_configuration
        # Add middleman app's images_dir by default
        SvgHeartsYou.configure do |config|
          config.svg_paths << File.join(Dir.pwd, app.settings.source, app.settings.images_dir)
        end
      end
    end
  end
end

::Middleman::Extensions.register(:svg_hearts_you, SvgHeartsYou::Extensions::MiddlemanExtension)

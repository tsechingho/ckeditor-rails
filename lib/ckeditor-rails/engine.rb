require 'ckeditor-rails/asset_url_processor'

module Ckeditor
  module Rails
    class Engine < ::Rails::Engine
      initializer 'ckeditor.assets.precompile', group: :all do |app|
        app.config.assets.precompile += Ckeditor::Rails::Asset.new.files
      end

      # Follow sprockets-rails 3.3.0+ to use postprocessor of Sprockets
      # https://github.com/rails/sprockets-rails/blob/v3.3.0/lib/sprockets/railtie.rb#L121
      initializer 'ckeditor.asset_url_processor' do |app|
        if ::Sprockets.respond_to? :register_postprocessor
          ::Sprockets.register_postprocessor 'text/css', ::Ckeditor::Rails::AssetUrlProcessor
        end
      end

      rake_tasks do
        load "ckeditor-rails/tasks.rake"
      end
    end
  end
end

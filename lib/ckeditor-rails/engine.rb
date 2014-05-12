module Ckeditor
  module Rails
    class Engine < ::Rails::Engine
      initializer "ckeditor_rails.assets_precompile", :group => :all do |app|
        app.config.assets.precompile += %W(
          ckeditor/*.js
          ckeditor/*.css
          ckeditor/*.png
          ckeditor/*.gif
          ckeditor/*.html
          ckeditor/*.md
        )
      end

      rake_tasks do
        load "ckeditor-rails/tasks.rake"
      end
    end
  end
end

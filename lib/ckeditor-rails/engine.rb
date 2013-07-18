module Ckeditor
  module Rails
    class Engine < ::Rails::Engine
      config.assets.precompile += %W(
        ckeditor/*.js
        ckeditor/*.css
        ckeditor/*.png
        ckeditor/*.gif
        ckeditor/*.html
        ckeditor/*.md
      )

      rake_tasks do
        load "ckeditor-rails/tasks.rake"
      end
    end
  end
end

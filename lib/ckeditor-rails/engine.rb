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
    end
  end
end

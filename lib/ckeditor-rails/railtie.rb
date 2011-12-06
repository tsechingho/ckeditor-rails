module Ckeditor
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "configure assets of ckeditor", :group => :all do |app|
        app.config.assets.precompile += %w( ckeditor/*.js ckeditor/*.css )
      end
    end
  end
end

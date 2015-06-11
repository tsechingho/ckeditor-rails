module Ckeditor
  module Rails
    class Engine < ::Rails::Engine
      initializer 'ckeditor.assets.precompile', group: :all do |app|
        app.config.assets.precompile += Ckeditor::Rails::Asset.new.files
      end

      rake_tasks do
        load "ckeditor-rails/tasks.rake"
      end
    end
  end
end

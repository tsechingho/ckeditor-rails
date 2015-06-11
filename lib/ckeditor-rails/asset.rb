module Ckeditor
  module Rails
    class Asset

      attr_reader :name, :root

      def initialize name = 'ckeditor', path = '../vendor/assets'
        @name = name
        @root = Ckeditor::Rails.root_path.join path
      end

      def image_files
        path = root.join('images', name)
        files = Dir.glob(path.join('plugins', '**', '*.{png,gif,jpg}')).reject { |file|
          invalid_plugin_file?(file)
        }
        files += Dir.glob(path.join('skins', '**', '*.{png,gif,jpg}')).reject { |file|
          invalid_skin_file?(file)
        }
        files
      end

      def javascript_files
        path = root.join('javascripts', name)
        files = Dir.glob(path.join('*.js'))
        files += Dir.glob(path.join('lang', '*.js')).reject { |file|
          invalid_lang_file?(file)
        }
        files += Dir.glob(path.join('plugins', '**', '*.{js,html}')).reject { |file|
          invalid_plugin_file?(file) or invalid_lang_file?(file)
        }
        files
      end

      def stylesheet_files
        path = root.join('stylesheets', name)
        files = Dir.glob(path.join('*.css'))
        files += Dir.glob(path.join('plugins', '**', '*.css')).reject { |file|
          invalid_plugin_file?(file)
        }
        files += Dir.glob(path.join('skins', '**', '*.css')).reject { |file|
          invalid_skin_file?(file)
        }
        files
      end

      def files
        files = []
        files += image_files
        files += javascript_files
        files += stylesheet_files
        files
      end

      private

      def languages
        Ckeditor::Rails.assets_languages
      end

      def plugins
        Ckeditor::Rails.assets_plugins
      end

      def skins
        Ckeditor::Rails.assets_skins
      end

      def invalid_lang_file? file
        return false if languages.nil?
        return false unless file.include? '/lang/'
        not languages.include? File.basename(file, '.*')
      end

      def invalid_plugin_file? file
        return false if plugins.nil?
        retrun false unless file.include? '/plugins/'
        plugins.none? { |plugin| file.include? "/#{plugin}/" }
      end

      def invalid_skin_file? file
        return false if skins.nil?
        return false unless file.include? '/skins/'
        skins.none? { |skin| file.include? "/#{skin}/" }
      end

    end
  end
end

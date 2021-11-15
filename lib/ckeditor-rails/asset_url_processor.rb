module Ckeditor
  module Rails
    # Rewrites urls in CSS files with the digested paths
    class AssetUrlProcessor
      REGEX = /url\(\s*["']?(?!(?:\#|data|http))([^"'\s)]+)\s*["']?\)/

      def self.stylesheet_files
        @stylesheet_files ||= ::Ckeditor::Rails::Asset.new.stylesheet_files
      end

      def self.assets_base_path(context = nil)
        return ::Ckeditor::Rails.assets_base_path unless context

        "#{context.assets_prefix}/ckeditor"
      end

      def self.call(input)
        return { data: input[:data] } unless stylesheet_files.include?(input[:filename])

        context = input[:environment].context_class.new(input)
        path_prefix = assets_base_path()
        matched_folders = input[:filename].match(/\/ckeditor\/(plugins|skins)\/([\w-]+)\//)

        data = input[:data].gsub(REGEX) { |_match|
          raw_asset_path = context.asset_path($1)
          if raw_asset_path.starts_with?(path_prefix)
            "url(#{raw_asset_path})"
          elsif matched_folders
            "url(#{path_prefix}/#{matched_folders[1]}/#{matched_folders[2]}#{raw_asset_path.gsub('/..', '')})"
          else
            "url(#{path_prefix}#{raw_asset_path})"
          end
        }

        { data: data }
      end
    end
  end
end

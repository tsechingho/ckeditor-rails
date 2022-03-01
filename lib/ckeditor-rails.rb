require 'ckeditor-rails/version'

module Ckeditor
  module Rails

    mattr_accessor :assets_languages
    @@assets_languages = nil

    mattr_accessor :assets_plugins
    @@assets_plugins = nil

    mattr_accessor :assets_skins
    @@assets_skins = nil

    mattr_writer :assets_base_path
    @@assets_base_path = nil

    class << self
      def configure
        yield self
      end

      def root_path
        @root_path ||= Pathname.new(File.expand_path('..', __FILE__))
      end

      def default_plugins
        %W[
          a11yhelp
          about
          clipboard
          colordialog
          dialog
          div
          find
          flash
          forms
          iframe
          image
          link
          liststyle
          pastefromword
          preview
          scayt
          smiley
          specialchar
          table
          tabletools
          templates
          wsc
        ]
      end

      def default_skins
        %w[moono-lisa]
      end

      def default_base_path
        return "#{::Sprockets::Railtie.config.assets.prefix}/ckeditor" if defined? ::Sprockets

        "#{::Rails.application.config.assets.prefix}/ckeditor"
      end

      def assets_base_path
        return @@assets_base_path unless @@assets_base_path.nil?

        if @@assets_base_path.respond_to? :call
          self.assets_base_path = @@assets_base_path.call
        elsif !@@assets_base_path.is_a? String
          self.assets_base_path = default_base_path
        end

        relative_path = ::Rails.application.config.action_controller.relative_url_root
        self.assets_base_path = File.join(relative_path, @@assets_base_path) if relative_path && @@assets_base_path

        self.assets_base_path = @@assets_base_path.sub(/\/\z/, '') if @@assets_base_path.ends_with?('/')

        @@assets_base_path
      end
    end

  end
end

require 'ckeditor-rails/asset'

case ::Rails.version.to_s
when /^[4567]/
  require 'ckeditor-rails/engine'
when /^3\.[12]/
  require 'ckeditor-rails/engine3'
when /^3\.[0]/
  require 'ckeditor-rails/railtie'
end if defined? ::Rails

require 'ckeditor-rails/version'

module Ckeditor
  module Rails

    mattr_accessor :assets_languages
    @@assets_languages = nil

    mattr_accessor :assets_plugins
    @@assets_plugins = nil

    mattr_accessor :assets_skins
    @@assets_skins = nil

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
        %w[moono]
      end
    end

  end
end

require 'ckeditor-rails/asset'

case ::Rails.version.to_s
when /^[456]/
  require 'ckeditor-rails/engine'
when /^3\.[12]/
  require 'ckeditor-rails/engine3'
when /^3\.[0]/
  require 'ckeditor-rails/railtie'
end if defined? ::Rails

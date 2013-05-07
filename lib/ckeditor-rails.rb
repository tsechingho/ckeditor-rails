require 'ckeditor-rails/version'

module Ckeditor
  module Rails
    case ::Rails.version.to_s
    when /^4/
      require 'ckeditor-rails/engine'
    when /^3\.[12]/
      require 'ckeditor-rails/engine3'
    when /^3\.[0]/
      require 'ckeditor-rails/railtie'
    end
  end
end

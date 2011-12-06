require "ckeditor-rails/version"

module Ckeditor
  module Rails
    if ::Rails.version < "3.1"
      require "ckeditor-rails/railtie"
    else
      require "ckeditor-rails/engine"
    end
  end
end

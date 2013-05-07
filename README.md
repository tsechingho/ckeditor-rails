# CKEditor for rails asset pipeline

[CKEditor](http://ckeditor.com/) is a library for WYSIWYG editor to be used inside web pages.

The `ckeditor_rails` gem integrates the `CKEditor` with the Rails asset pipeline.

And it would work with following environments:

* ruby 1.9.3+
* rails 3.0+

## Basic Usage

### Install ckeditor_rails gem

Include `ckeditor_rails` in Gemefile

    gem 'ckeditor_rails'

Then run `bundle install`

### Include CKEditor javascript assets

Add to your `app/assets/javascripts/application.js` after `//= require jquery_ujs` to work with jQuery

    //= require ckeditor-jquery

### Modify form field for CKEditor

Add `ckeditor` class to text area tag

    <%= f.text_area :content, :class => 'ckeditor' %>

## Advanced Usage

### Include customized configuration javascript for CKEditor

Add your `app/assets/javascripts/ckeditor/config.js.coffee` like

    CKEDITOR.editorConfig = (config) ->
      config.language = "zh"
      config.uiColor = "#AADC6E"
      true

### Include customized CKEDITOR_BASEPATH setting

Add your `app/assets/javascripts/ckeditor/basepath.js.coffee` like

    <%
      base_path = ''
      if ENV['PROJECT'] =~ /editor/i
        base_path << "/#{Rails.root.basename.to_s}/"
      end
      base_path << Rails.application.config.assets.prefix
      base_path << '/ckeditor/'
    %>
    var CKEDITOR_BASEPATH = '<%= base_path %>';

### Include customized stylesheet for contents of CKEditor

Add your `app/assets/stylesheets/ckeditor/contents.css.scss` like

    body {
      font-size: 14px;
      color: gray;
      background-color: yellow;
    }
    ol,ul,dl {
      *margin-right:0px;
      padding:4 20px;
    }

## Gem maintenance

Maintain `ckeditor_rails` gem with `Rake` commands.

Update origin CKEditor source files.

    rake update_ckeditor VERSION=4.1.1

Publish gem.

    rake release

## License

CKEditor use [CKEditor license](http://ckeditor.com/license).

Other parts of gem use MIT license.

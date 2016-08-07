# CKEditor for rails asset pipeline

[CKEditor](http://ckeditor.com/) is a library for WYSIWYG editor to be used inside web pages.

The `ckeditor_rails` gem integrates the `CKEditor` with the Rails asset pipeline.

And it would work with following environments:

* ruby 1.9.3+
* rails 3.0+

## Basic Usage

### Install ckeditor_rails gem

Include `ckeditor_rails` in Gemefile

```ruby
gem 'ckeditor_rails'
```

Then run `bundle install`

### Include CKEditor javascript assets

Add to your `app/assets/javascripts/application.js` after `//= require jquery_ujs` to work with jQuery

``` javascript
//= require ckeditor-jquery
```

### Modify form field for CKEditor

Add `ckeditor` class to text area tag

``` ruby
<%= f.text_area :content, :class => 'ckeditor' %>
```

### Initialize CKEditor in Javascript file

``` javascript
$('.ckeditor').ckeditor({
  // optional config
});
```

### Deployment

Since version 4.1.3, non-digested assets of `ckeditor-rails` will simply be copied after digested assets were compiled.

Eric Anderson, thanks.

## Advanced Usage

### Include customized configuration javascript for CKEditor

Add your `app/assets/javascripts/ckeditor/config.js.coffee` like

``` coffee
CKEDITOR.editorConfig = (config) ->
  config.language = "zh"
  config.uiColor = "#AADC6E"
  true
```

### Include customized CKEDITOR_BASEPATH setting

Add your `app/assets/javascripts/ckeditor/basepath.js.erb` like

``` ruby
<%
  base_path = ''
  if ENV['PROJECT'] =~ /editor/i
    base_path << "/#{Rails.root.basename.to_s}/"
  end
  base_path << Rails.application.config.assets.prefix
  base_path << '/ckeditor/'
%>
var CKEDITOR_BASEPATH = '<%= base_path %>';
```

### Include customized stylesheet for contents of CKEditor

Add your `app/assets/stylesheets/ckeditor/contents.css.scss` like

``` scss
body {
  font-size: 14px;
  color: gray;
  background-color: yellow;
}
ol,ul,dl {
  *margin-right:0px;
  padding:4 20px;
}
```

### Configure plugins, languages, and skins of CKEditor assets

Add `ckeditor_rails.rb` to `config/initializers/`

``` ruby
Ckeditor::Rails.configure do |config|
  # default is nil for all languages, or set as %w[en zh]
  config.assets_languages = nil

  # default is nil for all plugins,
  # or set as white list: %w[image link liststyle table tabletools]
  # or set as black list: config.default_plugins - %w[about a11yhelp]
  config.assets_plugins = nil

  # default is nil for all skins, or set as %w[moono]
  config.assets_skins = nil
end
```

## Gem maintenance

Maintain `ckeditor_rails` gem with `Rake` commands.

Update origin CKEditor source files.

    rake update_ckeditor VERSION=4.5.10

Publish gem.

    rake release

## Troubleshooting

#### CKEditor only loading after page refresh

This is due to interference with Turbolinks -

The problem stems from the link itself so in order to resolve this issue you must disable turbolinks in the div containing the link pointing to where CKEditor is.

You can visit the Rails Turbolinks Repo for detailed documentation
https://github.com/rails/turbolinks/#opting-out-of-turbolinks

**Example**

    <div class="example" data-no-turbolink>
    ...
    </div>

#### Asset Compilation Process Does Not Produce JS and/or CSS Files

If you observe an issue (especially in Heroku environment) where asset compilation process skips JS and or CSS files, try adding the following line to `app/environments/production.rb` (or config file for the environment where you observe the issue):

``` ruby
config.assets.precompile += ['ckeditor/*']
```

## License

CKEditor use [CKEditor license](http://ckeditor.com/license).

Other parts of gem use MIT license.

require "thor"

class SourceFile < Thor
  include Thor::Actions
  source_root 'tmp'

  desc "fetch VERSION", "fetch source files from http://ckeditor.com/"
  def fetch(version)
    download_url = file_url(version)
    extract_path = self.class.source_root
    archive_file = "#{extract_path}/#{filename(version)}"

    in_root do
      say_status("       fetch", archive_file, :green)
      get(download_url, archive_file)
      if File.exist?(archive_file)
        FileUtils.mkdir_p(extract_path)
        extract(archive_file, extract_path)
        FileUtils.rm_rf(archive_file)
      end
    end

    inside "lib" do
      gsub_file "ckeditor-rails/version.rb", /VERSION\s=\s"(\d|\.)+"$/ do |match|
        %Q{VERSION = "#{version}"}
      end
    end if File.exist?(extract_path)
  end

  desc "move", "move source files to vendor/assets"
  def move
    self.destination_root = "vendor/assets"

    copy_file "ckeditor/adapters/jquery.js", "javascripts/ckeditor/adapters/jquery.js"
    copy_file "ckeditor/ckeditor.js", "javascripts/ckeditor/ckeditor.js"
    copy_file "ckeditor/ckeditor_basic.js", "javascripts/ckeditor/ckeditor_basic.js"
    copy_file "ckeditor/config.js", "javascripts/ckeditor/config.js"
    copy_file "ckeditor/contents.css", "stylesheets/ckeditor/contents.css"

    directory "ckeditor/images", "images/ckeditor/images"
    directory "ckeditor/lang", "javascripts/ckeditor/lang"

    copy_file "ckeditor/LICENSE.html", "javascripts/ckeditor/LICENSE.html"

    directory "ckeditor/plugins", "javascripts/ckeditor/plugins"
    move_image_files_of_plugins

    copy_image_files_of_skin(%w{kama office2003 v2})

    directory "ckeditor/themes", "javascripts/ckeditor/themes"
  end

  desc "fix", "fix some css caused precompile error"
  def fix
    self.destination_root = "vendor/assets"
    inside destination_root do
      skin_names = %w{kama office2003 v2}
      skin_names.each do |name|
        gsub_file "stylesheets/ckeditor/skins/#{name}/dialog.css", /\+margin/, "margin"
        gsub_file "stylesheets/ckeditor/skins/#{name}/editor.css", /filter\:\;/, ""
      end
      gsub_file "stylesheets/ckeditor/skins/office2003/editor.css", /\!height\:28px\;\!line-height\:28px\;/, ""
    end
  end

  desc "convert", "convert css to sass file by sass-convert"
  def convert
    self.destination_root = "vendor/assets"
    inside destination_root do
      skin_names = %w{kama office2003 v2}
      skin_names.each do |name|
        path = "stylesheets/ckeditor/skins/#{name}"
        run("sass-convert -F css -T sass #{path}/dialog.css #{path}/dialog.css.sass")
        run("sass-convert -F css -T sass #{path}/editor.css #{path}/editor.css.sass")
        run("sass-convert -F css -T sass #{path}/templates.css #{path}/templates.css.sass")
        remove_file "#{path}/dialog.css"
        remove_file "#{path}/editor.css"
        remove_file "#{path}/templates.css"
      end
    end
  end

  desc "clean", "clean up useless files"
  def cleanup
    self.destination_root = "vendor/assets"
    FileUtils.rm_rf(self.class.source_root)
  end

  protected

  def file_url(version)
    "http://download.cksource.com/CKEditor/CKEditor/CKEditor%20#{version}/#{filename(version)}"
  end

  def filename(version)
    "ckeditor_#{version}.tar.gz"
  end

  def extract(file_path, output_path)
    system("tar --exclude=*.php --exclude=*.asp -C '#{output_path}' -xzf '#{file_path}' ckeditor")
  end

  def move_image_files_of_plugins
    files = Dir.glob("#{destination_root}/javascripts/ckeditor/plugins/*/*/*")
    files.each do |file|
      if file =~ /\.(png|gif)$/
        filename = file.sub("#{destination_root}/javascripts/", '')
        destination_path = filename.sub(/\/\w+\.\w+$/, '')
        in_root do
          FileUtils.mkdir_p("#{destination_root}/images/#{destination_path}")
          FileUtils.mv(file, "#{destination_root}/images/#{filename}")
        end
      end
    end
  end

  def copy_image_files_of_skin(skin_names = %w{kama office2003 v2})
    skin_names.each do |name|
      copy_file "ckeditor/skins/#{name}/dialog.css", "stylesheets/ckeditor/skins/#{name}/dialog.css"
      copy_file "ckeditor/skins/#{name}/editor.css", "stylesheets/ckeditor/skins/#{name}/editor.css"
      copy_file "ckeditor/skins/#{name}/icons.png", "images/ckeditor/skins/#{name}/icons.png"
      copy_file "ckeditor/skins/#{name}/icons_rtl.png", "images/ckeditor/skins/#{name}/icons_rtl.png"
      directory "ckeditor/skins/#{name}/images", "images/ckeditor/skins/#{name}/images"
      copy_file "ckeditor/skins/#{name}/skin.js", "javascripts/ckeditor/skins/#{name}/skin.js"
      copy_file "ckeditor/skins/#{name}/templates.css", "stylesheets/ckeditor/skins/#{name}/templates.css"
    end
  end
end

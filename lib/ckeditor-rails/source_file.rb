require "thor"

class SourceFile < Thor
  include Thor::Actions
  source_root 'tmp'

  desc "fetch VERSION", "fetch source files from http://ckeditor.com/"
  def fetch version
    download_url = file_url version
    archive_file = "#{source_root}/#{filename(version)}"

    in_root do
      say_status "       fetch", archive_file, :green
      get download_url, archive_file
      if File.exist? archive_file
        FileUtils.mkdir_p source_root
        extract archive_file, source_root
        FileUtils.rm_rf archive_file
      end
    end

    inside "lib" do
      gsub_file "ckeditor-rails/version.rb", /VERSION\s=\s"(\d|\.)+"$/ do |match|
        %Q{VERSION = "#{version}"}
      end
    end if File.exist? source_root
  end

  desc "move", "move source files"
  def move
    FileUtils.rm_rf destination_root

    [
      ['js', 'javascripts'],
      ['css', 'stylesheets'],
    ].each do |(type, asset_path)|
      Dir["#{source_root}/ckeditor/*.#{type}"].each do |file|
        file = File.basename file
        copy_file "ckeditor/#{file}", "#{asset_path}/ckeditor/#{file}"
      end
    end

    copy_file "ckeditor/LICENSE.md", "javascripts/ckeditor/LICENSE.md"
    directory "ckeditor/lang", "javascripts/ckeditor/lang"
    copy_plugins
    copy_skins
  end

  desc "clean", "clean up useless files"
  def cleanup
    FileUtils.rm_rf source_root
  end

  protected

  def file_url version
    "http://download.cksource.com/CKEditor/CKEditor/CKEditor%20#{version}/#{filename(version)}"
  end

  def filename version
    "ckeditor_#{version}_full.tar.gz"
  end

  def extract file_path, output_path
    system "tar -x -f '#{file_path}' -C '#{output_path}' ckeditor"
  end

  def copy_plugins
    Dir["#{source_root}/ckeditor/plugins/*"].each do |plugin|
      copy_all "plugins/#{File.basename plugin}"
    end
  end

  def copy_skins
    Dir["#{source_root}/ckeditor/skins/*"].each do |skin|
      copy_all "skins/#{File.basename skin}"
    end
  end

  def copy_all path
    copy_type path, 'css', 'stylesheets'
    copy_type path, 'js', 'javascripts'
    copy_type path, 'png', 'images'
    copy_type path, 'gif', 'images'
    copy_type path, 'jpg', 'images'
  end

  def copy_type path, type, asset_path
    files = Dir["#{source_root}/ckeditor/#{path}/**/*.#{type}"]
    files.each do |file|
      file = file.sub /^#{Regexp.escape source_root}\//, ''
      copy_file file, "#{asset_path}/#{file}"
    end
  end

  def source_root
    self.class.source_root
  end
end

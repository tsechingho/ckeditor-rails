#!/usr/bin/env rake
require 'bundler/gem_tasks'
require File.expand_path('../lib/ckeditor-rails/source_file', __FILE__)

desc 'Update CKEditor Library, VERSION is required.'
task 'update_ckeditor' do
  files = SourceFile.new
  files.fetch ENV['VERSION']
  files.destination_root = 'vendor/assets'
  files.move
  files.fix_css
  files.cleanup
end

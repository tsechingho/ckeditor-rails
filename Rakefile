#!/usr/bin/env rake
require "bundler/gem_tasks"
require File.expand_path('../lib/ckeditor-rails/source_file', __FILE__)

desc "Update CKEditor Library, VERSION is required."
task "update-ckeditor" do
  files = SourceFile.new
  files.fetch ENV['VERSION']
  files.move
  files.fix
  files.cleanup
end

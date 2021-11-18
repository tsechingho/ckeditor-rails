require 'fileutils'

desc "Create nondigest versions of all ckeditor digest assets"
task "assets:precompile" do
  fingerprint = /\-([0-9a-f]{32}|[0-9a-f]{64})\./
  files = Dir["#{File.join('public', Rails.configuration.assets.prefix)}/ckeditor/**/*"]

  # sort files having same digest with/without .gz by file mtime to have same order
  # otherwise copy order of nondigest file with/without .gz could be different
  sorted_files = files.sort_by { |file| File.mtime(file) }.reverse
  sorted_files.each do |file|
    next unless file =~ fingerprint
    nondigest = file.sub fingerprint, '.'
    if !File.exist?(nondigest) or File.mtime(file) > File.mtime(nondigest)
      FileUtils.cp file, nondigest, verbose: true
    end
  end
end

require 'fileutils'

desc "Create nondigest versions of all ckeditor digest assets"
task "assets:precompile" do
  fingerprint = /\-([0-9a-f]{32}|[0-9a-f]{64})\./
  for file in Dir["#{File.join('public', Rails.configuration.assets.prefix)}/ckeditor/**/*"]
    next unless file =~ fingerprint
    nondigest = file.sub fingerprint, '.'
    if !File.exist?(nondigest) or File.mtime(file) > File.mtime(nondigest)
      FileUtils.cp file, nondigest, verbose: true
    end
  end
end

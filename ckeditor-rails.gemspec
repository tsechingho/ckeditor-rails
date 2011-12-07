# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ckeditor-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tse-Ching Ho"]
  gem.email         = ["tsechingho@gmail.com"]
  gem.description   = %q{CKEditor is a javascript library of the WYSIWYG rich-text editor. This gem integrates CKEditor with Rails asset pipeline for easy of use.}
  gem.summary       = %q{Integrate CKEditor javascript library with Rails asset pipeline}
  gem.homepage      = "https://github.com/tsechingho/ckeditor-rails"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "ckeditor_rails"
  gem.require_paths = ["lib"]
  gem.version       = Ckeditor::Rails::VERSION

  gem.add_dependency "railties", "~> 3.0"
  gem.add_dependency "thor",     "~> 0.14"
  gem.add_development_dependency "bundler", "~> 1.0"
  gem.add_development_dependency "rails",   "~> 3.0"
end

# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "rust_playground_highlight"
  gem.version       = '0.1.2'
  gem.authors       = ["IanWhitney"]
  gem.email         = "ian@ianwhitney.com"
  gem.description   = %q{Automatically add links to the Rust Playground for code samples in your Jekyll site.}
  gem.summary       = %q{Adds a 'Run' button to your Rust code samples. You can choose to have the code in Rust Playground be dynamically generated or generated from a Gist. See the Readme for more information.}
  gem.homepage      = "https://github.com/IanWhitney/rust_playground_highlight"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.license       = "MIT"

  gem.add_dependency "jekyll", ">= 2.0", "< 4.0"
end

# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sassc/version"

Gem::Specification.new do |spec|

  spec.name          = "sassc"
  spec.version       = SassC::VERSION
  spec.authors       = ["Ryan Boland"]
  spec.email         = ["ryan@tanookilabs.com"]
  spec.summary       = "Use libsass with Ruby!"
  spec.description   = "Use libsass with Ruby!"
  spec.homepage      = "https://github.com/sass/sassc-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.required_ruby_version = ">= 2.0.0"

  spec.require_paths = ["lib"]

  spec.platform      = Gem::Platform::RUBY
  spec.extensions    = ["ext/extconf.rb"]

  spec.add_development_dependency "minitest", "~> 5.5.1"
  spec.add_development_dependency "minitest-around"
  spec.add_development_dependency "test_construct"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rake-compiler-dock"

  spec.add_dependency "ffi", "~> 1.9"

  gem_dir = File.expand_path(File.dirname(__FILE__)) + "/"

  libsass_dir = File.join(gem_dir, 'ext', 'libsass')
  if !File.directory?(libsass_dir)
    $stderr.puts "Error: ext/libsass not checked out. Please run:\n\n"\
                 "  git submodule update --init"
    exit 1
  end

  Dir.chdir(libsass_dir) do
    submodule_relative_path = File.join('ext', 'libsass')
    `git ls-files`.split($\).each do |filename|
      next if filename =~ %r{(^("?test|docs|script)/)|\.md$|\.yml$}
      spec.files << File.join(submodule_relative_path, filename)
    end
  end

end

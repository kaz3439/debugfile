# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "debugfile"
  spec.version       = "0.0.1"
  spec.authors       = ["kaz3439"]
  spec.email         = ["k.hayashi.info@gmail.com"]
  spec.description   = %q{You can store files in your tmporary directory orderd by date}
  spec.summary       = %q{You can store files in your tmporary directory orderd by date. For example, when you file uploader fails to complete uploading process, you can get the file for debug.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nagios_client/version'

Gem::Specification.new do |spec|
  spec.name          = "nagios_client"
  spec.version       = NagiosClient::VERSION
  spec.authors       = ["Pavel Svirsky"]
  spec.email         = ["hexer.rus@gmail.com"]
  spec.license       = "MIT"
  spec.summary       = %q{Nagios clent for ruby}
  spec.description   = %q{Ruby cleint for Nagios based on Nokogiri}
  spec.homepage      = "http://example.com"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
#    spec.metadata['allowed_push_host'] = ""
#  else
#    raise "RubyGems 2.0 or newer is required to protect against " \
#      "public gem pushes."
#  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "redcarpet", "~> 1.17"
  spec.add_development_dependency "yard", "~> 0.7.5"
end

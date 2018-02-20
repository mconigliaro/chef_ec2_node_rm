lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chef_ec2_node_rm/meta"

Gem::Specification.new do |spec|
  spec.name = ChefEc2NodeRm::NAME
  spec.version = ChefEc2NodeRm::VERSION
  spec.authors = ChefEc2NodeRm::AUTHORS
  spec.email = ChefEc2NodeRm::AUTHORS.map { |obj| obj.match(/<(.*?)>/)[1] }

  spec.summary = %q{Automatically delete chef node/client data on EC2}
  spec.description = %q{Automatically delete chef node/client data on EC2}
  spec.homepage = ChefEc2NodeRm::URL
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'minitest-autotest', '~> 1.0'
  spec.add_development_dependency 'rubocop', '~> 0.45'
  spec.add_development_dependency 'yard', '~> 0.9'

  spec.add_dependency 'aws-sdk-sqs', '~> 1.3'
end

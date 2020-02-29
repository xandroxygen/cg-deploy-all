lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cg_deploy/version"

Gem::Specification.new do |spec|
  spec.name          = "cg-deploy-all"
  spec.license       = ""
  spec.version       = CgDeploy::VERSION
  spec.authors       = ["Xander Moffatt"]
  spec.email         = ["xmoffatt@instructure.com"]

  spec.summary       = "Deploy multiple envs at once"
  spec.metadata["allowed_push_host"] = "to-do: Set to 'http://mygemserver.com'"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ['cg-deploy-all']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency('rdoc')
  spec.add_dependency('methadone', '~> 2.0.2')
  spec.add_dependency('tty-command', '~> 0.9.0')
  spec.add_development_dependency('test-unit')
end

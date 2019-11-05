require 'pathname'
require 'yaml'
require "cg_deploy/version"
require "cg_deploy/checks"
require "cg_deploy/config"
require "cg_deploy/envs"
require "cg_deploy/exceptions"

module CgDeploy
  class CLI
    def self.run(options)
      Checks.run_all
      config = Config.new
      envs = options[:e]

      envs_to_deploy = Envs.build_envs(config.get_environments, envs)
      puts envs_to_deploy
    end
  end
end

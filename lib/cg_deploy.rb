require 'pathname'
require 'yaml'
require 'thread'
require 'tty-command'
require 'pastel'

require "cg_deploy/version"
require "cg_deploy/checks"
require "cg_deploy/config"
require "cg_deploy/envs"
require "cg_deploy/exceptions"
require "cg_deploy/cloudgate"
require "cg_deploy/parallel"
require "cg_deploy/shell"

include Methadone::SH
include Methadone::CLILogging

module CgDeploy
  class CLI
    def self.run(options)
      Checks.run_all
      config = Config.new
      cg = Cloudgate.new(config.get_cg_version)
      pastel = Pastel.new


      envs = options[:e]
      is_serial = options[:serial]
      tag = options[:t]
      user = options[:u]

      envs_to_deploy = Envs.build_envs(config.get_environments, envs)

      puts pastel.green "\n*** Matched Environments ***"
      puts pastel.yellow envs_to_deploy

      puts pastel.green "\n *** Deploy Command ***"
      puts pastel.yellow cg.get_command("<env>", options)
      
      puts pastel.green "\nContinue? (y/n)"
      confirmation = gets.strip
      if confirmation != 'y'
        puts pastel.red "...exiting without deploying"
        return
      else
        puts pastel.blue "...deploying"

        commands = envs_to_deploy.map { |env| [ cg.get_command(env, tag, user), env ] }
        
        if is_serial 
          commands.each { |c, env| Shell.exec(c, env) }
        else
          Parallel.exec(commands){ |c, env| Shell.exec(c, env) }
        end
      end
    end
  end
end

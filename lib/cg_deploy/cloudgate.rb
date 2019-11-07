module CgDeploy
  class Cloudgate
    def initialize(required_version)
      @cg_version = get_correct_version(required_version)
    end

    def get_correct_version(required_version)
      installed_cg_versions = Gem::Specification.find_all_by_name('cloudgate').map &:version
      correct_version = installed_cg_versions.find { |v| Gem::Requirement.create(required_version).satisfied_by?(v)}
      raise VersionMismatch.new(required_version, installed_cg_versions) if correct_version.nil?
      correct_version
    end

    def get_command(env, options)
      base_command = "cg _#{@cg_version}_ deploy -e #{env}"
      
      if options[:tag] 
        base_command << " -t #{options[:tag]}"
      end

      if options[:user]
        base_command << " -u #{options[:user]}"
      end

      if options[:repo]
        base_command << " -r #{options[:repo]}"
      end

      if options[:pool]
        base_command << " -p #{options[:pool]}"
      end

      if !options['aws-account-check']
        base_command << " --no-aws-account-check"
      end

      if !options['run-hooks']
        base_command << " --no-run-hooks"
      end

      if !options['assume-deployer-role']
        base_command << " --no-assume-deployer-role"
      end

      base_command
    end
  end
end

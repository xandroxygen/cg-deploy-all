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

    def get_command(env, tag, user)
      base_command = "cg _#{@cg_version}_ deploy -e #{env}"
      
      if tag 
        base_command << " -t #{tag}"
      end

      if user
        base_command << " -u #{user}"
      end

      base_command
    end
  end
end

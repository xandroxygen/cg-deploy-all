module CgDeploy
  class Envs
    def self.build_envs(possible_envs, requested_envs)
      requested_envs = requested_envs.split(",")
      
      envs_to_deploy = []
      requested_envs.each do |env|
        if env.include? "*" 
          regex = Regexp.new(env.sub!("*", ".*"))
          matched_envs = possible_envs.select { |env| env =~ regex}

          raise EnvironmentNotFound.new(env, possible_envs) unless matched_envs.length > 0

          envs_to_deploy.concat matched_envs
        else
          envs_to_deploy << env
        end
      end
      
      envs_to_deploy.each do |env|
        raise EnvironmentNotFound.new(env, possible_envs) unless possible_envs.include? env
      end

      envs_to_deploy
    end
  end
end
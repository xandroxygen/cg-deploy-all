module CgDeploy
  class Parallel
    def self.exec(commands)
      commands
        .map{ |command| Thread.new{ self.ignoring_exceptions{ yield(command) } } }
        .each{ |t| t.join }
    end

    def self.ignoring_exceptions
      begin
        yield
      rescue Exception => e
        STDERR.puts e.message
      end
    end
  end
end
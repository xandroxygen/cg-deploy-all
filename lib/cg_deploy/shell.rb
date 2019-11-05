module CgDeploy
  class Shell
    def self.print(prefix, line)
      if prefix != ""
        puts prefix + ": " + line 
      else 
        puts line
      end
    end

    def self.exec(command, prefix="")
      Open3.popen3(command) do |stdout, stderr| 
        while line=stderr.gets do 
          self.print(prefix, line)
        end
      end
      self.print(prefix, "complete!")
    end
  end
end
module CgDeploy
  class Shell
    def self.print(line, prefix)
      if prefix != ""
        puts prefix + ": " + line 
      else 
        puts line
      end
    end

    def self.exec(command, prefix="")
      Open3.popen3(command) do |stdout, stderr| 
        while line=stderr.gets do 
          self.print(line, prefix)
        end
      end
      self.print("complete!", prefix)
    end
  end
end
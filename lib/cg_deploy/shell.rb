require_relative "printer"

module CgDeploy
  class Shell
    def self.exec(command, env)
      printer = CgDeploy::Printer.new($stdout, { env: env })
      cmd = TTY::Command.new(color: true, pty: true, printer: printer)
      cmd.run(command)
    end
  end
end
module CgDeploy
  # mostly copied from TTY::Command::Printers::Pretty,
  # but modified to include the env as a prefix
  class Printer < TTY::Command::Printers::Abstract
    TIME_FORMAT = "%5.3f %s".freeze

        def initialize(*)
          super
          @env = options.fetch(:env)
        end

        def print_command_start(cmd, *args)
          message = ["Running #{decorate(cmd.to_command, :yellow, :bold)}"]
          message << args.map(&:chomp).join(' ') unless args.empty?
          write(cmd, message.join)
        end

        def print_command_out_data(cmd, *args)
          message = args.map(&:chomp).join(' ')
          write(cmd, "\t#{message}", out_data)
        end

        def print_command_err_data(cmd, *args)
          return
        end

        def print_command_exit(cmd, status, runtime, *args)
          runtime = TIME_FORMAT % [runtime, pluralize(runtime, 'second')]
          message = ["Finished in #{runtime}"]
          message << " with exit status #{status}" if status
          message << " (#{success_or_failure(status)})"
          write(cmd, message.join)
        end

        # Write message out to output
        #
        # @api private
        def write(cmd, message, data = nil)
          out = []
          unless message.include?("\r")
            out << "[#{decorate(@env, :green)}] "
            out << "#{message}\n"
          end
          output << out.join
        end

        private

        # Pluralize word based on a count
        #
        # @api private
        def pluralize(count, word)
          "#{word}#{'s' unless count.to_f == 1}"
        end

        # @api private
        def success_or_failure(status)
          if status == 0
            decorate('successful', :green, :bold)
          else
            decorate('failed', :red, :bold)
          end
        end
  end
end
require "cg/deploy/all/version"

module Cg
  module Deploy
    module All
      class Error < StandardError; end
      
      class CLI
        def self.run(options)
          puts options
        end
      end
    end
  end
end

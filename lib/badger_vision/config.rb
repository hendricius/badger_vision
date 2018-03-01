require "badger_vision/configuration"

module BadgerVision
  module Config
    def configure
      if block_given?
        yield configuration
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  # This exposes the configuration methods in global scope, so
  # we can directly use those like: `BadgerVision.configuration`.
  #
  extend Config
end

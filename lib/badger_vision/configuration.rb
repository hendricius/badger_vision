module BadgerVision
  class Configuration
    attr_accessor :api_key, :api_host, :version

    def initialize
      @api_host ||= "http://places2.csail.mit.edu"
    end

    def base_path
      ""
    end
  end
end

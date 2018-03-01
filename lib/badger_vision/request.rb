require "faraday"
require "badger_vision/config"

module BadgerVision
  class Request
    # Initialize a Request
    #
    # @param http_method [Symbol] HTTP verb as sysmbol
    # @param endpoint [String] The relative API endpoint
    # @param data [Hash] Attributes / Options as a Hash
    #
    def initialize(http_method, endpoint)
      @data        = data
      @endpoint    = endpoint
      @http_method = http_method
    end

    # Make a HTTP Request
    #
    # @param options [Hash] Additonal options hash
    # @return Hash
    #
    def request(options = {})
      connection.send(http_method, api_endpoint, default_options.merge(options)).body
    end

    # Make a HTTP POST Request
    #
    # @param endpoint [String] The relative API endpoint
    # @param options [Hash] The additional query params
    # @return Hash
    #
    def self.post(endpoint, options = {})
      new(:post, endpoint).request(options)
    end

    private

    attr_reader :client, :data, :http_method

    def config
      BadgerVision.configuration
    end

    def default_options
      {
        random: Time.now.to_i * 1000,
        data: nil,
        date: Time.now.to_i * 1000,
        demoimg: 0,
      }
    end

    def places_host
      config.api_host
    end

    def api_endpoint
      ["", config.base_path, @endpoint].join("/").squeeze("/")
    end

    def faraday_options
      {
        url: places_host
      }
    end

    def connection
      @connection ||= Faraday.new(faraday_options) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end

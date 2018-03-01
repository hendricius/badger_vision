require "faraday"
require "json"
require "pry"
require "badger_vision/config"
require "badger_vision/request"

module BadgerVision
  class Client
    def initialize(request_options: {})
      @request_options = request_options
    end

    # Extract tags from a given image URL
    def self.image_information(url)
      new(request_options: {url: url}).image_information
    end

    def image_information
      body = Request.post("cgi-bin/image.py", @request_options)
      ImageInformationResponse.new(parse_response(body))
    end

    private

    def parse_response(body)
      JSON.parse(body, symbolize_names: true)
    end

    class ImageInformationResponse
      def initialize(response)
        @response = response || {}
      end

      def attributes
        @response.fetch(:attributes, []).split(",").map(&:strip)
      end

      def type
        @response.fetch(:type, nil)
      end

      def scenes
        @response.fetch(:scenes, []).split(",").map(&:strip).map do |scene|
          Scene.new(parse_scene(scene))
        end
      end

      private

      def parse_scene(scene)
        name, probability = extract_scene_data(scene)
        {
          name: name,
          probability: probability.to_f
        }
      end

      def extract_scene_data(scene)
        # format: lagoon (0.299)
        scene.match(/^(\w*)\s\((.*)\)/)&.captures
      end
    end

    class Scene
      attr_reader :name, :probability

      def initialize(name:, probability:)
        @name = name
        @probability = probability
      end
    end
  end
end

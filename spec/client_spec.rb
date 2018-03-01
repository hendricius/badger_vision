require "spec_helper"

RSpec.describe BadgerVision::Client do
  def service
    klass = described_class
    allow(BadgerVision::Request).to receive(:post) do
      {
        "attributes": "natural light, open area, man-made, sunny, clouds, far-away horizon, swimming, boating, diving",
        "segmentation": "5439.jpg",
        "type": "outdoor",
        "scenes": "lagoon (0.299), beach_house (0.279), boathouse (0.105)",
        "topcategory": "lagoon"
      }
    end
    klass
  end

  describe ".image_information" do
    it "retrieves image information for a given image" do
      info = service.image_information(url: 'https://www.telegraph.co.uk/content/dam/Travel/Destinations/Asia/Maldives/Maldives%20lead-xlarge.jpg')
      expect(info.attributes).to eq(['natural light', 'open area', 'man-made', 'sunny', 'clouds', 'far-away horizon', 'swimming', 'boating', 'diving'])
      expect(info.type).to eq('outdoor')

      scenes = info.scenes
      expect(scenes.length).to eq(3)
      expect(scenes[0].name).to eq('lagoon')
      expect(scenes[0].probability).to eq(0.299)
      expect(scenes[1].name).to eq('beach_house'), scenes[1].inspect
      expect(scenes[1].probability).to eq(0.279), scenes[1].inspect
      expect(scenes[2].name).to eq('boathouse'), scenes[2].inspect
      expect(scenes[2].probability).to eq(0.105), scenes[2].inspect
    end
  end
end

require "badger_vision/version"
require "badger_vision/request"
require "badger_vision/client"

module BadgerVision
  def self.root
    File.dirname(__dir__)
  end
end

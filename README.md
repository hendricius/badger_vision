# Badger Vision 🐼

Extract concepts and tags from images using badger vision. It's a wrapper
around the Places365 project allowing you to understand what landscape
information is available a given images

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'badger_vision'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install badger_vision

## Usage

You always need to pass a URL of the image to the service.

```
url = 'https://www.telegraph.co.uk/content/dam/Travel/Destinations/Asia/Maldives/Maldives%20lead-xlarge.jpg'
response = BadgerVision::Client.image_information(url)

```

Your response has the following methods:

```
response.attributes
#=> ['natural light', 'open area', 'man-made', 'sunny', 'clouds', 'far-away horizon', 'swimming', 'boating', 'diving']

response.type
#=> 'outdoor'

scenes = info.scenes

scenes.first.name
#=> 'lagoon'

scenes.first.probability
#=> 0.299

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Hendricius/badger_vision.

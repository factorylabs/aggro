# Aggro

A social aggregator that will help you avoid the common frustration of API hell.

Supported services:

* Twitter (coming soon)
* Instagram (coming soon)
* Facebook (tentative)

## Installation

Add this line to your application's Gemfile:

    gem 'aggro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aggro

## Usage

### Rails 3.x

First things first: create an initializer (such as `config/initializers/aggro.rb`) and configure which services you would like to use:

```
Aggro.configure do |c|
  c.services = [ :twitter, :instagram ]
end
```

Some services (like Twitter) increase your rate limit threshold if you authenticate. To authenticate, set authentication options on a service-by-service basis:

```
Aggro.configure do |c|
  c.services = [ :instagram ] # no authentication here
  c.services += {
    twitter: {
      key: "abc123abc123abc123ocUQ",
      secret: "12111abcWXE123NabcaVLf5432PX123Nvkcbw253H2"
    }
  }
end
```

You're ready to get your aggregate on.

### Aggregate by User
Aggregating by user allows you to grab the most recent data for a given user. Start by setting up a AggroUser object:

    user = Aggro::User.new(instagram: "heimidal", twitter: "heimidal")

You're now ready to aggregate!

    user.aggregate #=> #<Aggro::Collection>

This collection object works much like an array and contains `Aggro::SocialItem` objects  you can work with.

You can also aggregate many users at once:

    user1 = Aggro::User.new(instagram: "heimidal", twitter: "heimidal")
    user2 = Aggro::User.new(instagram: "factorylabs", twitter: "factorylabs")
    
    Aggro.aggregate [user1, user2] #=> #<Aggro::Collection>
    
### Working with ActiveRecord
To make things more convenient, we have provided a simple ActiveRecord plugin.

Start by marking your model as an social-aware model:

    class User < ActiveRecord::Base
      aggro_aware
    end
    
This provides a `#to_aggro_user` method on your model. By default, your model will be scanned for a handle to use for all configured services by calling `#servicename_handle`. For example, if you have configured Aggro to aggregate from Twitter and Instagram, Aggro will automatically try to set handles by calling `self.twitter_handle` and `self.instagram_handle`.

To specify a different method for a given service handle, pass an option to the `aggro_aware` call:

    class User < ActiveRecord::Base
      aggro_aware( twitter: :twitter_username )
    end
    
### Working with SocialItems
An `Aggro::SocialItem` object represents a tweet from Twitter or photo from Instagram. The common interface provides a number of methods that you may find useful.

#### service
Calling `social_item.service` will return a symbol identifying the origin service of this message.

    social_item = user.aggregate.first #=> #<Aggro::SocialItem @service=:twitter @message="test message">
    social_item.service #=> :twitter

#### message
Calling `social_item.message` will return the tweet or instagram photo description.

    social_item = user.aggregate.first #=> #<Aggro::SocialItem @service=:twitter @message="test message">
    social_item.message #=> "test message"

#### tags
Calling `social_item.tags` will return any hashtags included in the message.

    social_item = user.aggregate.first #=> #<Aggro::SocialItem @service=:twitter @message="test message #factory">
    social_item.tags #=> ["factory"]

#### mentions
Calling `social_item.mentions` will return user handles mentioned in the message.

    social_item = user.aggregate.first #=> #<Aggro::SocialItem @service=:twitter @message="test message @factorylabs">
    social_item.tags #=> ["factorylabs"]

#### media
Calling `social_item.media` will return an array of all associated media items. This will include links, video URLs, and images.

    social_item = user.aggregate.first #=> #<Aggro::SocialItem @service=:twitter @message="test">
    social_item.media #=> [#<Aggro::Image>, #<Aggro::Url>]
    
See "Working with Media Items" below.

#### images
Calling `social_item.images` will return an array of all associated images, whether attached via link or directly. For Instagram, only one image will be associated to a given SocialItem. For Twitter, multiple images may be associated.

    social_item = user.aggregate.first #=> #<Aggro::SocialItem @service=:twitter @message="test">
    social_item.images #=> [#<Aggro::Image>]

See "Working with Media Items" below.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# Pusherable

[![Build Status](https://travis-ci.org/tonycoco/pusherable.png)](https://travis-ci.org/tonycoco/pusherable)

Adds callback hooks for your ActiveRecord models for sending messages to a Pusher channel.

## Installation

Add this line to your application's Gemfile:

    gem 'pusherable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pusherable

## Usage

Add in the following lines to any ActiveRecord model class:

    pusherable(YOUR_CHANNEL)

On your subscribed client(s), events will be triggered by Pusher reflecting your ActiveRecord create/update/destroy actions.

### Example

If you have a model called, __Story__, and you create a new record, Pusher will receive an event called, "story.create".
It will also carry a payload of data containing the __model_id__

Here is a list of the ActiveRecord callbacks that trigger Pusher events...

```
"model.create" => after_create
"model.update" => after_update
"model.destroy" => before_destroy
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

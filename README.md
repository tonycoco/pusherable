# Pusherable

[![Build Status](https://travis-ci.org/tonycoco/pusherable.png)](https://travis-ci.org/tonycoco/pusherable)

Adds callback hooks for your _ActiveRecord_ models for sending messages to a _Pusher_ channel.

## Installation

Install and configure _Pusher_ to work on your application by following the [pusher gem's instructions](https://github.com/pusher/pusher-gem).

Then, add this line to your application's _Gemfile_:

    gem 'pusherable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pusherable

## Usage

Add in the following lines to any _ActiveRecord_ model class:

    pusherable('some_channel')

_Pusherable_ has a default channel of `test_channel`, just like the _Pusher_ example docs, that it will publish to.

On your subscribed client(s), events will be triggered by _Pusher_ reflecting your _ActiveRecord_ create/update/destroy actions.

Here is a list of the _ActiveRecord_ callbacks that trigger _Pusher_ events...

    ActiveRecord Callback => Triggered Event
    ----------------------------------------
    after_create => "model.create"
    after_update => "model.update"
    before_destroy => "model.destroy"

### Example

If you have an _ActiveRecord_ model called, _Post_, and you create a new record, _Pusher_ will receive an event called, "post.create".
It will also carry a payload of data containing a _JSON_ representation of the record (literally calling `to_json` on the record).

The following callbacks that trigger _Pusher_ events in this _Post_ example will then be...

    ActiveRecord Callback => Triggered Event
    ----------------------------------------
    after_create => "post.create"
    after_update => "post.update"
    before_destroy => "post.destroy"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

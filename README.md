# Pusherable

[![Build Status](https://travis-ci.org/tonycoco/pusherable.png)](https://travis-ci.org/tonycoco/pusherable)

Adds callback hooks for your `ActiveModel` models for sending messages to a `Pusher` channel.

## Requirements

* Ruby 2.0+

## Installation

Install and configure `Pusher` to work on your application by following the [pusher gem's instructions](https://github.com/pusher/pusher-gem).

Then, add this line to your application's `Gemfile`:

    gem "pusherable"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pusherable

## Usage

Add in the following lines to any `ActiveModel` model class:

    pusherable("some_channel")

A `pusherable` model triggers events on a default channel of `test_channel`, just like the `Pusher` example docs, that it will publish to.

On your subscribed client(s), events will be triggered by `Pusher` reflecting your `ActiveModel` create, update and destroy actions.

Here is a list of the `ActiveModel` callbacks that trigger `Pusher` events...

`ActiveModel` callbacks (Non-Transactional):

    after_create will trigger "model.create"
    after_update will trigger "model.update"
    before_destroy will trigger "model.destroy"

`ActiveModel` callbacks (Transactional):

    after_commit on :create will trigger "model.create"
    after_commit on :update will trigger "model.update"
    after_commit on :destroy will trigger "model.destroy"

### Example

If you have an `ActiveModel` model called, `Post`, and you create a new record, `Pusher` will receive an event called, `"post.create"`.
It will also carry a payload of data containing a JSON representation of the record (literally calling `#to_json` on the record).

The following callbacks that trigger `Pusher` events in this `Post` example will then be...

`ActiveModel` callbacks (Non-Transactional):

    after_create will trigger "post.create"
    after_update will trigger "post.update"
    before_destroy will trigger "post.destroy"

`ActiveModel` callbacks (Transactional):

    after_commit on :create will trigger "post.create"
    after_commit on :update will trigger "post.update"
    after_commit on :destroy will trigger "post.destroy"

Currently this gem extends `ActiveRecord::Base` and `Mongoid::Document` (if defined).

`ActiveRecord::Base.extend Pusherable`

For any other `ActiveModel` compliant data store, simply mirror this statement.

This gem supports soft deletes when used with [paranoia](https://github.com/radar/paranoia).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

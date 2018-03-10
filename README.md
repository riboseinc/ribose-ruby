# Ribose

[![Build
Status](https://travis-ci.org/riboseinc/ribose-ruby.svg?branch=master)](https://travis-ci.org/riboseinc/ribose-ruby)
[![Code
Climate](https://codeclimate.com/github/riboseinc/ribose-ruby/badges/gpa.svg)](https://codeclimate.com/github/riboseinc/ribose-ruby)
[![Gem Version](https://badge.fury.io/rb/ribose.svg)](https://badge.fury.io/rb/ribose)

The Ruby Interface to the Ribose API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ribose"
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install ribose
```

## Configure

We need to setup Ribose API configuration before we can perform any request
throughout this client

First, obtain an API token [as per this Github wiki](https://github.com/riboseinc/ribose-api/wiki/Obtaining-the-API-Token).
Using the token, configure the client by adding an initializer with the
following code:

```ruby
Ribose.configure do |config|
  config.api_token = "SECRET_API_TOKEN"
  config.user_email = "your-email@example.com"

  # There are also some default configurations. Normally you do not need to
  # change those unless you have some very specific use cases.
  #
  # config.debug_mode = false
  # config.api_host = "www.ribose.com"
end
```

Or:

```ruby
Ribose.configuration.api_token = "SECRET_API_TOKEN"
Ribose.configuration.user_email = "your-email@example.com"
```

## Usage

### App Data

App data can be retrieved using the `AppData.all` interface.

```ruby
Ribose::AppData.all
```

### App Relation

#### List app relations

To retrieve the list of app relations, we can use the `AppRelation.all`
interface.

```ruby
Ribose::AppRelation.all
```

#### Fetch an app relation

To retrieve the details for a specific app relation, we can use the following
interface.

```ruby
Ribose::AppRelation.fetch(app_relation_id)
```

### Profile

#### Fetch user profile

```ruby
Ribose::Profile.fetch
```

#### Update user profile

```ruby
Ribose::Profile.update(first_name: "John", last_name: "Doe")
```

#### Set user login

```ruby
Ribose::Profile.set_login(login_name)
```

### Settings

#### List user's settings

To list user's settings we can use the `Setting.all` interface, and it will
return all of the user's settings.

```ruby
Ribose::Setting.all
```

#### Fetch a setting

To fetch the details for any specific settings we can use the `Setting.fetch`
interface with the specific Setting ID, and it will return the details for that
setting.

```ruby
Ribose::Setting.fetch(setting_id)
```

#### Update a setting

```ruby
Ribose::Setting.update(setting_id, **new_updated_attributes_hash)
```

### Spaces

#### List user's Spaces

To list a user's Spaces we can use the `Space.all` interface, and it will
retrieve all of the Spaces for the currently configured user.

```ruby
Ribose::Space.all
```

#### Fetch a user Space

To retrieve the details for a Space we can use the `Space.fetch(space_id)`.

```ruby
Ribose::Space.fetch(space_id)
```

#### Create a user Space

To create a new user Space,

```ruby
Ribose::Space.create(
  access:            "private",
  space_category_id: 12,
  name:              "The amazing Ribose Space",
  description:       "Description about your Space"
)
```

#### Update a user Space

```ruby
Ribose::Space.update("space_uuid", name: "New updated name", **other_attributes)
```

#### Remove a user Space

To remove an existing Space,

```ruby
Ribose::Space.remove(space_uuid, confirmation: true)
```

### Members

The members endpoint are Space-specific.

To retrieve the member details under any specific Space, we can use this
interface.

#### List space members

To retrieve the list of members,

```ruby
Ribose::Member.all(space_id, options)
```

#### Delete a space member

```ruby
Ribose::Member.delete(space_id, member_id, options)
```

#### Fetch Member Role

```ruby
Ribose::MemberRole.fetch(space_id, member_id, options)
```

#### Assign a role to member

```ruby
Ribose::MemberRole.assign(space_id, member_id, role_id)
```

### Files

#### List of Files

To retrieve the list of files for any specific Space,

```ruby
Ribose::SpaceFile.all(space_id, options)
```

#### Fetch a file details

```ruby
Ribose::SpaceFile.fetch(space_id, file_id, options = {})
```

#### Create a file upload

```ruby
Ribose::SpaceFile.create(space_id, file: "The complete file path", **attributes)
```

#### Update a space file

```ruby
Ribose::SpaceFile.update(space_id, file_id, new_file_attributes = {})
```

#### Remove a space file

```ruby
Ribose::SpaceFile.delete(space_id, file_id)
```

### Conversations

#### Listing Space Conversations

```ruby
Ribose::Conversation.all(space_id, options = {})
```

#### Retrieve a conversation details

```ruby
Ribose::Conversation.fetch(space_id, conversation_id)
```

#### Create A New Conversation

```ruby
Ribose::Conversation.create(
  space_id, name: "Sample conversation", tag_list: "sample, conversation"
)
```

#### Update a conversation

```ruby
Ribose::Conversation.update(space_id, conversation_id, new_attributes_hash)
```

#### Remove A Conversation

```ruby
Ribose::Conversation.destroy(space_id: "space_id", conversation_id: "12345")
```

### Message

#### List Conversation Messages

```ruby
Ribose::Message.all(space_id: space_uuid, conversation_id: conversation_uuid)
```

#### Create a new message

```ruby
Ribose::Message.create(
  space_id:        space_uuid,
  conversation_id: conversation_uuid,
  contents:        "Provide your message body here",
)
```

#### Update an existing message

```ruby
Ribose::Message.update(
  space_id:        space_uuid,
  message_id:      message_uuid,
  conversation_id: conversation_uuid,
  contents:        "The new content for message",
)
```

#### Remove a message

```ruby
Ribose::Message.remove(
  space_id:        space_uuid,
  message_id:      message_uuid,
  conversation_id: conversation_uuid,
)
```

### Feeds

#### List user feeds

To retrieve the list of user feeds,

```ruby
Ribose::Feed.all
```

### Widgets

#### List widgets

To retrieve the list of widgets,

```ruby
Ribose::Widget.all
```

### Stream

#### List of stream notifications

To retrieve the list of notifications,

```ruby
Ribose::Stream.all
```

### Leaderboard

#### Retrieve the current leadership board

To retrieve the current leadership board,

```ruby
Ribose::Leaderboard.all
```

### Connections

### List of connections

To retrieve the list of connections, we can use the `Connection.all` interface
and it will return the connection as `Sawyer::Resource`.

```ruby
Ribose::Connection.all
```

#### Connection suggestions

To retrieve the list of user connection suggestions,

```ruby
Ribose::Connection.suggestions
```

### Invitations

#### List connection invitations

```ruby
Ribose::ConnectionInvitation.all
```

#### List Space invitations

```ruby
Ribose::SpaceInvitation.all
```

#### Fetch a connection invitation

```ruby
Ribose::ConnectionInvitation.fetch(invitation_id)
```

#### Create mass connection invitations

```ruby
Ribose::ConnectionInvitation.create(
  emails: ["email-one@example.com", "email-two@example.com"],
  body: "This contains the details message about the invitation",
)
```

#### Accept a connection invitation

```ruby
Ribose::ConnectionInvitation.accept(invitation_id)
```

#### Reject a connection invitation

```ruby
Ribose::ConnectionInvitation.reject(invitation_id)
```

#### Cancel a connection invitation

```ruby
Ribose::ConnectionInvitation.cancel(invitation_id)
```

#### Invite user to a Space

```ruby
Ribose::SpaceInvitation.create(
  state:      "0",
  space_id:   "123_456_789",
  invitee_id: "456_789_012",
  type:       "Invitation::ToSpace",
  body:       "Please join to this amazing Space",
)
```

#### Create Space invitation - Mass

```ruby
Ribose::SpaceInvitation.mass_create(
  space_id,
  emails:   ["email-one@example.com"],
  role_ids: ["role-for-email-address-in-sequance"],
  body:     "The complete message body for the invitation",
)
```

#### Update a Space invitation

```ruby
Ribose::SpaceInvitation.update(invitation_id, new_attributes_hash)
```

#### Accept a Space invitation

```ruby
Ribose::SpaceInvitation.accept(invitation_id)
```

#### Resend a Space invitation

```ruby
Ribose::SpaceInvitation.resend(invitation_id)
```

#### Reject a Space invitation

```ruby
Ribose::SpaceInvitation.reject(invitation_id)
```

#### Cancel a Space invitation

```ruby
Ribose::SpaceInvitation.cancel(invitation_id)
```

### Join Space Request

#### List Join Space Requests

```ruby
Ribose::JoinSpaceRequest.all
```

#### Fetch a join space request

```ruby
Ribose::JoinSpaceRequest.fetch(request_id)
```

#### Create a Join Space Request

```ruby
Ribose::JoinSpaceRequest.create(
  state:    0,
  Space_id: 123_456_789,
  type:     "Invitation::JoinSpaceRequest",
  body:     "Hi, I would like to join to your Space",
)
```

#### Accept a Join Space Request

```ruby
Ribose::JoinSpaceRequest.accept(invitation_id)
```

#### Reject a Join Space Requests

```ruby
Ribose::JoinSpaceRequest.reject(invitation_id)
```

#### Update an Join Space Requests

```ruby
Ribose::JoinSpaceRequest.update(invitation_id, new_attributes_hash)
```

### Calendar

#### List user calendars

To retrieve the list of calendars accessible to the current user,

```ruby
Ribose::Calendar.all
```

#### Fetch a calendar events

```ruby
Ribose::Calendar.fetch(calendar_ids, start: Data.today, length: 7)
```

#### Create a calendar

```ruby
Ribose::Calendar.create(
  owner_type: "User",
  owner_id:   "The Owner UUID",
  name:       "The name for the calendar",
)
```

#### Delete a calendar

```ruby
Ribose::Calendar.delete(calendar_id)
```

### User

#### Create a signup request

```ruby
Ribose::User.create(email: "user@example.com", **other_attributes)
```

#### Activate a signup request

```ruby
Ribose::User.activate(
  email:    "user@example.com",
  password: "ASecureUserPassword",
  otp:      "OTP Recived via the Email",
)
```

### Wikis

#### List wiki pages

```ruby
Ribose::Wiki.all(space_id, options = {})
```

#### Fetch a wiki page

```ruby
Ribose::Wiki.fetch(space_id, wiki_id, options = {})
```

#### Create a wiki page

```ruby
Ribose::Wiki.create(
  space_id, name: "Wiki Name", tag_list: "sample", **other_attributes_hash
)
```

### Update a wiki page

```ruby
Ribose::Wiki.update(
  space_id, wiki_id, **updated_attributes_hash
)
```

### Remove a wiki page

```ruby
Ribose::Wiki.delete(space_id, wiki_id)
```

## Development

We are following Sandi Metz's Rules for this gem, you can read the
[description of the rules here][sandi-metz] All new code should follow these
rules. If you make changes in a pre-existing file that violates these rules you
should fix the violations as part of your contribution.

### Setup

Clone the repository.

```sh
git clone https://github.com/riboseinc/ribose-ruby
```

Setup your environment.

```sh
bin/setup
```

Run the test suite

```sh
bin/rspec
```

## Contributing

First, thank you for contributing! We love pull requests from everyone. By
participating in this project, you hereby grant [Ribose Inc.][riboseinc] the
right to grant or transfer an unlimited number of non exclusive licenses or
sub-licenses to third parties, under the copyright covering the contribution
to use the contribution by all means.

Here are a few technical guidelines to follow:

1. Open an [issue][issues] to discuss a new feature.
1. Write tests to support your new feature.
1. Make sure the entire test suite passes locally and on CI.
1. Open a Pull Request.
1. [Squash your commits][squash] after receiving feedback.
1. Party!

## Credits

This gem is developed, maintained and funded by [Ribose Inc.][riboseinc]

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[riboseinc]: https://www.ribose.com
[issues]: https://github.com/riboseinc/ribose-ruby/issues
[squash]: https://github.com/thoughtbot/guides/tree/master/protocol/git#write-a-feature
[sandi-metz]: http://robots.thoughtbot.com/post/50655960596/sandi-metz-rules-for-developers

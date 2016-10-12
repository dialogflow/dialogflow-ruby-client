# The API.AI ruby gem

[![Gem Version](https://badge.fury.io/rb/api-ai-ruby.svg)](https://badge.fury.io/rb/api-ai-ruby)

A Ruby SDK to the https://api.ai natural language processing service.

## Installation
    gem install api-ai-ruby

## Basic Usage

Just pass correct credentials to **ApiAiRuby::Client** constructor

```ruby
client = ApiAiRuby::Client.new(
    :client_access_token => 'YOUR_CLIENT_ACCESS_TOKEN'
)
```
After that you can send text requests to the https://api.ai with command

```ruby
response = client.text_request 'hello!'
```

And voice requests with file stream

```ruby
file = File.new 'hello.wav'
response = client.voice_request(file)
```

Example answer:
```
{
  :id        => "6daf5ab7-276c-43ad-a32d-bf6831918492",
  :timestamp => "2015-12-22T08:42:15.785Z",
  :result    => {
    :source        => "agent",
    :resolvedQuery => "Hello",
    :speech        => "Hi! How are you?",
    :action        => "greeting",
    :parameters    => {},
    :contexts      => [],
    :metadata      => {
      :intentId   => "a5d685ab-1f19-46b0-9478-69f794553668",
      :intentName => "hello"
    }
  },
  :status    => {
    :code      => 200,
    :errorType => "success"
  }
}
```

**voice_request** and **text_request** methods returns symbolized https://api.ai response. Structure of response can be found at https://docs.api.ai/docs/query#response.

## Advanced usage

During client instantiating you can additionally set parameters like **api url**, request **language** and **version** (more info at https://docs.api.ai/docs/versioning, https://docs.api.ai/docs/languages)

```ruby
ApiAiRuby::Client.new(
    client_access_token: 'YOUR_ACCESS_TOKEN',
    api_lang: 'FR',
    api_base_url: 'http://example.com/v1/',
    api_version: 'YYYYMMDD',
    api_session_id: 'some_uuid_or_whatever'
)
```

And you also can send additional data to server during request, use second parameter of **text_request** and **voice_request** methods to do that

```ruby
    response = client.text_request 'Hello', :contexts => ['firstContext'], :resetContexts => true
    response = client.voice_request file, :timezone => "America/New_York"
```

More information about possible parameters can be found at https://docs.api.ai/docs/query page

## User Entities

Another possibility is to send and retrieve [custom entities](https://docs.api.ai/docs/userentities) to the server.

You can do it along with **query** request
```ruby
client.text_request 'call Mozart', entities: [
    {
        name: 'contacts',
        entries: [
            ApiAiRuby::Entry.new('Mozart', %w(Mozart Wolfgang)),
            ApiAiRuby::Entry.new('Salieri', %w(Salieri Antonio))
        ]
    }
]

# the same without ApiAiRuby::Entry wrapper

client.text_request 'call Mozart', entities: [
    {
        name: 'contacts',
        entries: [
            {value: 'Mozart', synonyms: %w(Mozart Wolfgang))},
            {value: 'Salieri', synonyms: %w(Salieri Antonio))},
        ]
    }
]
     
```

Or with separate **user_entities_request** object with full CRUD support:

```ruby

# preparations
entries_composers = [
    ApiAiRuby::Entry.new('Mozart', %w(Mozart Wolfgang)),
    ApiAiRuby::Entry.new('Salieri', %w(Salieri Antonio))
]

entries_unknown = [
    ApiAiRuby::Entry.new('John Doe', %w(John Unknown)),
    ApiAiRuby::Entry.new('Jane Doe', %w(Jane))
]

entity_contacts = ApiAiRuby::Entity.new('contacts', [entries_composers])

# let's go
uer = client.user_entities_request
uer.create(contacts) # or uer.create([entity1, entity2...])

client.text_request 'call Mozart' # will work

uer.update('contacts', entries_unknown)

client.text_request 'call Mozart' # will NOT work
client.text_request 'call John' # will work

uer.retrieve('contacts') # will return current state of user entity
uer.delete('contacts') # will remove user entities for given session    
       
```


#Error handling
**ApiAiRuby::Client** currently able to raise two kind of errors: **ApiAiRuby::ClientError** (due to configuration mismatch) and **ApiAiRuby::RequestError** in case of something goes wrong during request. For both kind of errors you can get **error.message** (as usual) and **ApiAiRuby::RequestError** can additionally give you code of server error (you can get it with **error.code**)

#Timeouts
**ApiAiRuby::Client** uses the [http gem](https://github.com/httprb/http) under the hood.  You can use ```timeout_options``` on the client to set these.
```ruby
ApiAiRuby::Client.new(
    client_access_token: 'YOUR_ACCESS_TOKEN',
    api_lang: 'FR',
    api_base_url: 'http://example.com/v1/',
    api_version: 'YYYYMMDD',
    api_session_id: 'some_uuid_or_whatever',
    timeout_options: [:global, { write: 1, connect: 1, read: 1 }]
)
```

Please see the [httprb wiki on timeouts](https://github.com/httprb/http/wiki/Timeouts) for more information.

#Changelog

* 1.2.1 - fixed UTF-8 in text-requests
* 1.2.0 - added configurable session_id and full userEntities support
* 1.1.4 - removed unused dependency and updated default API version 
* 1.1.3 - fixed non-correctly serialized parameters in new contexts during query send process
* 1.1.2 - fixed compatibility with ruby version less then 2.1.6

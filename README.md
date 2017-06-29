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

Or try to invocate intent via defined '[event](https://docs.api.ai/docs/concept-events)':

```ruby

response_zero = client.event_request 'MY_CUSTOM_EVENT_NAME';
response_one = client.event_request 'MY_EVENT_WITH_DATA_TO_STORE', {:param1 => 'value'}
response_two = client.event_request 'MY_EVENT_WITH_DATA_TO_STORE', {:some_param => 'some_value'}, :resetContexts => true

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
    response = client.voice_request file, :timezone => 'America/New_York'
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
            {value: 'Mozart', synonyms: %w(Mozart Wolfgang)},
            {value: 'Salieri', synonyms: %w(Salieri Antonio)}
        ]
    }
]

```

Or with separate **create_user_entities_request** object with full CRUD support:

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

entity_contacts = ApiAiRuby::Entity.new('contacts', entries_composers)

# let's go
uer = client.create_user_entities_request
uer.create(entity_contacts) # or uer.create([entity1, entity2...])

client.text_request 'call Mozart' # will work

uer.update('contacts', entries_unknown)

client.text_request 'call Mozart' # will NOT work
client.text_request 'call John' # will work

uer.retrieve('contacts') # will return current state of user entity
uer.delete('contacts') # will remove user entities for given session    

```
## Context
Also SDK has full support of [contexts](https://docs.api.ai/docs/contexts) API.AI endpoint with special object, called ```contexts_request```
Usage is simple:
```ruby

# some preparations
lifespan = 5
parameters = {
  :param_name => 'param_value'
}
name = 'test_context'

# you can create context using built-in model ApiAiRuby::Context
test_context = ApiAiRuby::Context.new(name, lifespan, parameters)
another_test_context = ApiAiRuby::Context.new('another_test_context')
one_more_test_context = ApiAiRuby::Context.new('one_more_test_context', 4)

# ok, we are ready

context_request = @client.create_contexts_request

# there are different options to be used with .create

context_request.create(test_context)
context_request.create([another_test_context, one_more_test_context])
context_request.create('one_more_super_final_mega_context')

context_request.retrieve('test_context') # will return you single context or nothing
context_request.list() # will return you list of all contexts used in current session
context_request.delete('test_context') # will remove single context
context_request.delete() # will remove all context in session

```

# Timeouts
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


# Error handling
**ApiAiRuby::Client** currently able to raise two kind of errors: **ApiAiRuby::ClientError** (due to configuration mismatch) and **ApiAiRuby::RequestError** in case of something goes wrong during request. For both kind of errors you can get **error.message** (as usual) and **ApiAiRuby::RequestError** can additionally give you code of server error (you can get it with **error.code**)


# Changelog

## 2.0.0
### Breaking:
- http gem dependency updated to 2.0, it does no longer raise `Errno::ETIMEDOUT`. Thanks to @tak1n

## 1.3.0 

### Non-breaking:
- contexts endpoint support (https://docs.api.ai/docs/contexts)
- better RDoc

### Breaking:
- ApiAiRuby::Client::user_entities_request renamed to ApiAiRuby::Client::create_user_entities_request
- ApiAiRuby::Entity::addEntry renamed to ApiAiRuby::Entity::add_entry

## Previous
* 1.2.3 - events support
* 1.2.2 - added configurable timeouts for requests (thanks [bramski](https://github.com/bramski))
* 1.2.1 - fixed UTF-8 in text-requests
* 1.2.0 - added configurable session_id and full userEntities support
* 1.1.4 - removed unused dependency and updated default API version
* 1.1.3 - fixed non-correctly serialized parameters in new contexts during query send process
* 1.1.2 - fixed compatibility with ruby version less then 2.1.6

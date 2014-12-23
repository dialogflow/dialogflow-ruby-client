api-ai-ruby
===========

Ruby SDK for api.ai

- API Wrapper for api.ai

It reqires ruby 2.0.0

## Instration

$gem install api.ai
- We're registrating to Ruby gems in few days

## Usage

### Initialize

```ruby
apiai = ApiAi.new do |config|
  config.access_token = "#{your_access_token}"
  config.subscription_key = "#{your_subscription_key}"
 end
```

### Query

```ruby
puts apiai.query("What is the weather in New York?")
```

You can also set some options using Hash
```ruby
q = "What is the weather in New York?"
opts = {lang: "en", timezone: "America/Los_Angeles"}
puts apiai.query(q, opts)
```

[api options detail]: http://api.ai/docs/reference/#query

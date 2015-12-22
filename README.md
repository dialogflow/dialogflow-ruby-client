# The API.AI ruby gem

A Ruby SDK to the https://api.ai natural language processing service.

## Installation
    gem install api-ai-ruby

## Basic Usage

    Just pass correct credentials to ApiAiRuby::Client constructor

    ```ruby
    client = ApiAiRuby::Client.new(
        :client_access_token => 'YOUR_ACCESS_TOKEN',
        :subscription_key => 'YOUR_SUBSCRIPTION_KEY'
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

    ```
        ...
        response[:result][:resolvedQuery] => 'hello'
        ...
    ```










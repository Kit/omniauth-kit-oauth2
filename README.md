# OmniAuth Kit OAuth2 Strategy

Strategy to authenticate with Kit via OAuth2 in OmniAuth.

Get your API key at: https://app.kit.com/account_settings/developer_settings Note the Client ID and the Client Secret.

For more details, read the Developer docs: https://developers.kit.com/v4

## Installation

Add to your `Gemfile`:

```ruby
gem 'omniauth-kit-oauth2'
```

Then `bundle install`.

## Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :kit_oauth2, client_id: ENV.fetch("KIT_CLIENT_ID"),
                        client_secret: ENV.fetch("KIT_CLIENT_SECRET"),
end
```

You can now access the OmniAuth Kit OAuth2 URL: `/auth/kit_oauth2`

## Auth Hash

Here's an example of an authentication hash available in the callback by accessing `request.env['omniauth.auth']`:

```ruby
{
  "provider" => "kit_oauth2",
  "uid" => 1,
  "info" => {
    "name" => "Creator",
    "email" => "creator@example.com"
  },
  "credentials" => {
    "token" => "abc123",
    "refresh_token" => "def456",
    "expires_at" => 123,
    "expires" => true
  },
  "extra" => {
    "raw_info" => {
      "user" => {
        "email" => "test@example.com"
      },
      "account" => {
        "name" => "Kit Greetings",
        "plan_type" => "creator",
        "primary_email_address" => "test@example.com",
        "created_at" => "2023-02-17T11:43:55Z",
        "id" => 26
      }
    }
  }
}
```

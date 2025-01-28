require "omniauth"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class KitOauth2 < OmniAuth::Strategies::OAuth2
      option :name, "kit_oauth2"
      option :client_options, { site: "https://app.kit.com", api_site: "https://api.kit.com" }

      uid do
        raw_info["account"]["id"]
      end

      info do
        {
          name: raw_info["account"]["name"],
          email: raw_info["account"]["primary_email_address"]
        }
      end

      extra do
        { raw_info: }
      end

      def raw_info
        @raw_info ||= access_token.get("#{options["client_options"]["api_site"]}/v4/account").parsed
      end

      def authorize_params
        super.merge(tenant_name: request.params["tenant_name"])
      end
    end
  end
end

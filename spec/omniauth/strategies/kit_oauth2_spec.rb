require 'omniauth-kit-oauth2'

RSpec.describe OmniAuth::Strategies::KitOauth2 do
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }
  let(:app) do
    lambda do
      [ 200, {}, [ 'Hello.' ] ]
    end
  end

  subject do
    OmniAuth::Strategies::KitOauth2.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) do
        request
      end
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe '#client_options' do
    it 'has correct site' do
      expect(subject.client.site).to eq('https://app.kit.com')
    end

    it 'has correct authorize_url' do
      expect(subject.client.options[:authorize_url]).to eq('oauth/authorize')
    end

    it 'has correct token_url' do
      expect(subject.client.options[:token_url]).to eq('oauth/token')
    end

    describe 'overrides' do
      context 'as strings' do
        it 'should allow overriding the site' do
          @options = { client_options: { 'site' => 'https://example.com' } }
          expect(subject.client.site).to eq('https://example.com')
        end

        it 'should allow overriding the authorize_url' do
          @options = { client_options: { 'authorize_url' => 'https://example.com' } }
          expect(subject.client.options[:authorize_url]).to eq('https://example.com')
        end

        it 'should allow overriding the token_url' do
          @options = { client_options: { 'token_url' => 'https://example.com' } }
          expect(subject.client.options[:token_url]).to eq('https://example.com')
        end
      end

      context 'as symbols' do
        it 'should allow overriding the site' do
          @options = { client_options: { site: 'https://example.com' } }
          expect(subject.client.site).to eq('https://example.com')
        end

        it 'should allow overriding the authorize_url' do
          @options = { client_options: { authorize_url: 'https://example.com' } }
          expect(subject.client.options[:authorize_url]).to eq('https://example.com')
        end

        it 'should allow overriding the token_url' do
          @options = { client_options: { token_url: 'https://example.com' } }
          expect(subject.client.options[:token_url]).to eq('https://example.com')
        end
      end
    end
  end

  describe '#authorize_params' do
    let(:request) { double('Request', params: { "tenant_name" => "test.com" }, cookies: {}, env: {}) }

    it 'should include tenant name passed in the request params' do
      expect(subject.authorize_params['tenant_name']).to eq('test.com')
    end
  end

  describe '#info' do
    let(:response_hash) do
      {
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
    end
    let(:client) do
      OAuth2::Client.new('abc', 'def') do |builder|
        builder.request :url_encoded
        builder.adapter :test do |stub|
          stub.get('/v4/account') { [ 200, { 'content-type' => 'application/json' }, response_hash.to_json ] }
        end
      end
    end
    let(:access_token) { OAuth2::AccessToken.from_hash(client, { 'access_token' => 'a' }) }
    before { allow(subject).to receive(:access_token).and_return(access_token) }

    it 'should return name and email' do
      expect(subject.info[:name]).to eq('Kit Greetings')
      expect(subject.info[:email]).to eq('test@example.com')
    end
  end
end

require_relative "lib/omniauth/kit_oauth2/version"

Gem::Specification.new do |spec|
  spec.name        = "omniauth-kit-oauth2"
  spec.version     = Omniauth::Kit::Oauth2::VERSION
  spec.authors     = [ "Kit" ]
  spec.email       = [ "engineering@kit.com" ]
  spec.homepage    = "https://developers.kit.com"
  spec.summary     = "Allows authenticating with Kit V4 API."

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Kit/omniauth-kit-oauth2/"
  spec.metadata["changelog_uri"] = "https://github.com/Kit/omniauth-kit-oauth2/"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  end

  spec.add_runtime_dependency "omniauth", "~> 2.1"
  spec.add_runtime_dependency "omniauth-oauth2", "~> 1.8"

  spec.add_development_dependency "debug", "~> 1.10"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "rake", "~> 13.2"
end

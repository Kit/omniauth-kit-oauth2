require_relative "lib/omniauth/kit_oauth2/version"

Gem::Specification.new do |spec|
  spec.name        = "omniauth-kit-oauth2"
  spec.version     = Omniauth::Kit::Oauth2::VERSION
  spec.authors     = ["Kit"]
  spec.email       = ["engineering@kit.com"]
  spec.homepage    = "https://kit.com"
  spec.summary     = "TODO: Summary of Omniauth::Kit::Oauth2."
  spec.description = "TODO: Description of Omniauth::Kit::Oauth2."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_runtime_dependency "omniauth", "~> 2.1"
  spec.add_runtime_dependency "omniauth-oauth2", "~> 1.8"
end

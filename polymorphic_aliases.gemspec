require_relative "lib/polymorphic_aliases/version"

Gem::Specification.new do |spec|
  spec.name        = "polymorphic_aliases"
  spec.version     = PolymorphicAliases::VERSION
  spec.authors     = ["mansakondo"]
  spec.email       = ["mansakondo22@gmail.com"]
  spec.homepage    = "https://github.com/mansakondo/polymorphic_aliases"
  spec.summary     = "An ActiveRecord extension to use aliases for your polymorphic associations."
  spec.license     = "MIT"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/mansakondo/polymorphic_aliases/blob/main/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.0"
end

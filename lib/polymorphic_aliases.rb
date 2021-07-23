require "polymorphic_aliases/version"
require "polymorphic_aliases/railtie"

module PolymorphicAliases
  require "polymorphic_aliases/active_record/associations/builder/belongs_to_polymorphic_association.rb"
  require "polymorphic_aliases/active_model/attribute_methods/polymorphic_attribute_aliases.rb"
end

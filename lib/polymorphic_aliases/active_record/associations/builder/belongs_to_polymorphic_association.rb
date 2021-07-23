module BelongsToPolymorphicAssociation
  extend ActiveSupport::Concern

  class_methods do
    private

    def valid_options(options)
      valid = super
      valid += [:types] if options[:polymorphic]
    end
  end
end

ActiveRecord::Associations::Builder::BelongsTo.prepend(BelongsToPolymorphicAssociation)

module BelongsToPolymorphicAssociation
  extend ActiveSupport::Concern

  class_methods do
    private

    def valid_options(options)
      valid = super
      valid += [:types] if options[:polymorphic]
      valid
    end

    def define_accessors(model, reflection)
      super

      mixin = model.generated_association_methods

      if reflection.polymorphic? && reflection.options[:types].present?
        define_aliases(mixin, reflection)
      end
    end

    def define_aliases(mixin, reflection)
      types            = reflection.options[:types]
      association_name = reflection.name

      types.each do |type|
        name = type.tableize.tr("/", "_").singularize
        type = type.inspect

        mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
          def #{name}
            if #{type} == self["#{association_name}_type"]
              association(:#{association_name}).reader
            end
          end
          def #{name}=(value)
            if #{type} == self["#{association_name}_type"]
              association(:#{association_name}).writer(value)
            end
          end
          def reload_#{name}
            if #{type} == self["#{association_name}_type"]
              association(:#{association_name}).force_reload_reader
            end
          end
        CODE
      end
    end
  end
end
ActiveRecord::Associations::Builder::BelongsTo.prepend(BelongsToPolymorphicAssociation)

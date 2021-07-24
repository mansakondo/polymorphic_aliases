# frozen_string_literal: true

module PolymorphicAttributeAliases
  VALID_PREFIXES  = %w( reload_ build_ create_ ).freeze
  VALID_SUFFIXES  = %w( = ).freeze

  private_constant :VALID_PREFIXES, :VALID_SUFFIXES

  def method_missing(method, *args, &block)
    prefix, attribute_name, suffix = decompose_method_name(method)

    self.class.reflect_on_all_associations(:belongs_to).each do |reflection|
      begin
        next unless (types = reflection.options[:types])
        next unless (target_type = attributes["#{reflection.name}_type"])
        next unless types.any? { |type| type.to_s.constantize == target_type.constantize }
        next unless target_type.constantize == attribute_name.camelize.constantize

        association_method_name = prefix + reflection.name.to_s + suffix
        return send(:"#{association_method_name}", *args, &block)
      rescue
        return super
      end
    end

    super
  end

  private

  def decompose_method_name(method_name)
    method_name = method_name.to_s

    prefix = ""
    affix  = method_name
    suffix = ""

    VALID_PREFIXES.each do |valid_prefix|
      next unless method_name.start_with?(valid_prefix)
      prefix = valid_prefix
      affix  = method_name.delete_prefix(valid_prefix)

      break
    end

    VALID_SUFFIXES.each do |valid_suffix|
      next unless method_name.ends_with?(valid_suffix)
      suffix = valid_suffix
      affix  = affix.delete_suffix(valid_suffix)

      break
    end

    return prefix, affix, suffix
  end
end

ActiveModel::AttributeMethods.prepend(PolymorphicAttributeAliases)

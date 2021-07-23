module PolymorphicAttributeAliases
  def method_missing(method, *args, &block)
    prefix, attribute_name, suffix = decompose_method_name(method)

    self.class.reflect_on_all_associations.each do |reflection|
      begin
        next unless (types = reflection.options[:types])
        next unless (target_type = attributes["#{reflection.name}_type"])
        next unless types.any? { |type| type.to_s.constantize == target_type.constantize }
        next unless target_type.constantize == attribute_name.camelize.constantize

        return send(:"#{prefix + reflection.name.to_s + suffix}", *args, &block)
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

    valid_prefixes.each do |valid_prefix|
      next unless method_name.start_with?(valid_prefix)
      prefix = valid_prefix
      affix  = method_name.delete_prefix(valid_prefix)
    end

    valid_suffixes.each do |valid_suffix|
      next unless method_name.ends_with?(valid_suffix)
      suffix = valid_suffix
      affix  = affix.delete_suffix(valid_suffix)
    end

    return prefix, affix, suffix
  end

  def valid_prefixes
    %w( reload_ build_ create_ )
  end

  def valid_suffixes
    %w( = )
  end
end

ActiveModel::AttributeMethods.prepend(PolymorphicAttributeAliases)

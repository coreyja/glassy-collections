module HashAttributeAssignment
  def initialize(hash={})
    assign_asstributes(hash)
  end

  def assign_asstributes(hash)
    hash.each do |key, value|
      instance_variable_set("@#{key}".to_sym, value)
    end
  end
end

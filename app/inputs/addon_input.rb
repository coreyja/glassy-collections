# frozen_string_literal: true
class AddonInput < SimpleForm::Inputs::StringInput
  def addon
    options[:addon]
  end
end

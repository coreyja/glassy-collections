# frozen_string_literal: true

class AddonInput < SimpleForm::Inputs::StringInput
  def addon(_wrapper_options)
    options[:addon]
  end
end

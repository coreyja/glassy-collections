class AddonInput < SimpleForm::Inputs::StringInput
  def addon
    options[:addon]
  end
end

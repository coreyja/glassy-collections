# frozen_string_literal: true

class PhotoInput < SimpleForm::Inputs::FileInput
  def input_html_options
    super.merge(accept: 'image/*')
  end
end

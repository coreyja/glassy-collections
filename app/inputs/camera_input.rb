# frozen_string_literal: true

class CameraInput < SimpleForm::Inputs::FileInput
  def input_html_options
    super.merge(capture: 'camera', accept: 'image/*')
  end
end

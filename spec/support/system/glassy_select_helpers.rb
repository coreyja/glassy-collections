module System
  module GlassySelectHelpers
    def fill_select_and_take_first_result(placeholder, query)
      page.find('.Select-placeholder', text: placeholder).click
      page.find('*:focus').send_keys query
      page.find('.Select-option.is-focused').click
    end
  end
end

RSpec.configure do |config|
  config.include System::GlassySelectHelpers, type: :system
end

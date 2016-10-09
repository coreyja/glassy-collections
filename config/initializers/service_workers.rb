# frozen_string_literal: true
Rails.application.configure do
  config.serviceworker.routes.draw do
    match '/sw.js'
  end
end

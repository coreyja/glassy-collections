# frozen_string_literal: true
namespace :yarn do
  task install: :environment do
    sh('./bin/yarn')
  end
end

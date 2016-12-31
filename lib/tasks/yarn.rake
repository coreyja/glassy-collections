# frozen_string_literal: true
namespace :yarn do
  task install: :environment do
    sh('./bin/npm')
  end
end

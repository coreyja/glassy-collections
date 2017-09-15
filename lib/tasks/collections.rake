# frozen_string_literal: true

namespace :collections do
  desc 'Create a Collection for each User and assign them as the owner. Add all their pendants to this collection.'
  task backfill_collections_from_users: :environment do
    User.find_each do |user|
      collection = Collection.create!(owners: [user], name: 'Personal Collection')
      user.pendants.find_each do |pendant|
        pendant.update! collection: collection
      end
    end
  end
end

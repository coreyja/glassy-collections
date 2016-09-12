class CreatePendantSearches < ActiveRecord::Migration
  def change
    create_view :pendant_searches
  end
end

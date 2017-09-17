class CreatePendantSearches < ActiveRecord::Migration[4.2]
  def change
    create_view :pendant_searches
  end
end

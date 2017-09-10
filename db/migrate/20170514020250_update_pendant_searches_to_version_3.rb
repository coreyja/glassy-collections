class UpdatePendantSearchesToVersion3 < ActiveRecord::Migration
  def change
    update_view :pendant_searches, version: 3, revert_to_version: 2
  end
end

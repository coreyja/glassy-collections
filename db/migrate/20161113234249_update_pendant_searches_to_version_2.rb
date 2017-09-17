class UpdatePendantSearchesToVersion2 < ActiveRecord::Migration[4.2]
  def change
    update_view :pendant_searches, version: 2, revert_to_version: 1
  end
end

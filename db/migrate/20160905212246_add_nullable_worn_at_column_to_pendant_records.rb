class AddNullableWornAtColumnToPendantRecords < ActiveRecord::Migration[4.2]
  def change
    add_column :pendant_records, :worn_on, :date, null: true
  end
end

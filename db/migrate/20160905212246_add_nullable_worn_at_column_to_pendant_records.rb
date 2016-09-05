class AddNullableWornAtColumnToPendantRecords < ActiveRecord::Migration
  def change
    add_column :pendant_records, :worn_on, :date, null: true
  end
end

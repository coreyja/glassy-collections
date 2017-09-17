class MakeWornAtNonNullable < ActiveRecord::Migration[4.2]
  def change
    change_column_null :pendant_records, :worn_on, false
  end
end

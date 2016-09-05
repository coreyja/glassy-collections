class MakeWornAtNonNullable < ActiveRecord::Migration
  def change
    change_column_null :pendant_records, :worn_on, false
  end
end

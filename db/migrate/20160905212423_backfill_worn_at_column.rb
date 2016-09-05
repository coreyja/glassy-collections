class BackfillWornAtColumn < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE pendant_records
      SET worn_on = date_trunc('day', created_at - interval '4 hours')
      WHERE worn_on is null;
    SQL
  end

  def down
  end
end

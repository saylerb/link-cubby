class AddDefaultReadStatusToLinks < ActiveRecord::Migration[5.0]
  def change
    change_column_default :links, :read, false
  end
end

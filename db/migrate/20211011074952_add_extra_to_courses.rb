class AddExtraToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :started_at, :datetime
    add_column :courses, :total_month, :integer, default: 0
    add_column :courses, :total_member, :integer, default: 0
  end
end

class CreateRegisters < ActiveRecord::Migration[6.1]
  def change
    create_table :registers do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :votes
      t.integer :user_id
      t.integer :likes
      t.integer :helpful

      t.timestamps
    end
  end
end

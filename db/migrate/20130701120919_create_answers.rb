class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      t.integer :votes
      t.integer :user_id
      t.integer :likes
      t.integer :helpful
      t.integer :question_id

      t.timestamps
    end
  end
end

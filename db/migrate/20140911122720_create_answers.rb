class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.references :user
      t.references :m_word
      t.string :characters
      t.boolean :correct
      t.timestamps
      t.index :question_id
      t.index :user_id
      t.index [:m_word_id, :correct]
    end
  end
end

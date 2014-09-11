class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.references :m_word
      t.string :katakana
      t.string :english
      t.boolean :correct
      t.timestamps
      t.index :question_id
      t.index [:m_word_id, :correct]
    end
  end
end

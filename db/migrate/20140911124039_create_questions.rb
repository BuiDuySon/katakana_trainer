class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user
      t.integer :num_m_words
      t.text :m_word_ids
      t.timestamps
    end
  end
end

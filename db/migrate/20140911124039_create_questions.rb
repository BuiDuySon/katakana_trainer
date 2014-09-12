class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :type
      t.references :user
      t.integer :num_m_words
      t.text :m_word_ids
      t.timestamps
      t.index :type
      t.index :user_id
    end
  end
end

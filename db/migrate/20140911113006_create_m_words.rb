class CreateMWords < ActiveRecord::Migration
  def change
    create_table :m_words do |t|
      t.string :katakana
      t.string :english
      t.timestamps
    end
  end
end

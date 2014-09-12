class Answer < ActiveRecord::Base
  UPDATABLE_PARAMS = :english, :m_word_id

  belongs_to :question
  belongs_to :m_word, class_name: "M::Word"
end

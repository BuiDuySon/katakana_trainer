class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :m_word, class_name: "M::Word"
end

class M::Word < ActiveRecord::Base
  attr_accessor :question_id

  has_many :answers

  def question
    return unless question_id
    Question.where(id: question_id).first
  end

  def question_word
    self.send question.m_word_question_type
  end

  def answer_word
    self.send question.m_word_answer_type
  end

end

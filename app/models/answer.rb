class Answer < ActiveRecord::Base
  UPDATABLE_PARAMS = :characters, :m_word_id

  belongs_to :question

  before_save :mark

  def m_word= m_word
    self.m_word_id = m_word.id
  end

  def m_word
    M::Word.find(self.m_word_id).tap do |m_word|
      m_word.question_id = question.id
    end
  end

  private
  def mark
    self.correct = self.characters == self.m_word.answer_word
    true
  end

end

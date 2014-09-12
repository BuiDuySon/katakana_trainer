class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  serialize :m_word_ids, Array
  before_save :update_num_m_words!

  def m_words
    M::Word.where(id: self.m_word_ids)
  end

  def m_words= _m_words
    self.m_word_ids = _m_words.map &:id
  end

  def m_words_to_answer
    M::Word.where(id: (self.m_word_ids - answers.pluck(:m_word_id)))
  end

  class << self
    def create_for! user
      question = Question.new(user_id: user.id)
      question.m_word_ids = WordPicker::Simple.new(user).pick
      question.save
      question
    end
  end

  private
  def update_num_m_words!
    self.num_m_words = self.m_word_ids.count
  end
end

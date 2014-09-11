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

  private
  def update_num_m_words!
    self.num_m_words = self.m_word_ids.count
  end
end

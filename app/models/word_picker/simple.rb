class WordPicker::Simple

  def initialize user
    @user = user
  end

  def pick
    word_ids = (M::Word.pluck(:id) - @user.m_word_ids)
      .sample Settings.question.num_words
  end

end

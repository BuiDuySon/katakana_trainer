class QuestionsController < BaseController

  def create
    type = if params[:type] == "katakana"
        "Question::KatakanaQuestion"
      else
        "Question::EnglishQuestion"
    end
    question = Question.joins(:answers).where("questions.user_id = ? and type = ?", current_user.id, type).group("questions.id").having("count(answers.id) < ?", 10).limit(1).first()
    question = Question.select(:id).where.not(id: Answer.select(:question_id).group(:question_id).order(:question_id)).where("questions.user_id = ? and type = ?", current_user.id, type).limit(1).first() unless question
    question = Question.create_for! current_user, params[:type] unless question
    redirect_to new_question_answer_path(question)
  end

end

class AnswersController < BaseController

  before_filter :load_question, only: [:create, :new]
  before_filter :build_object, only: :create

  def index
    return redirect_to(root_path) unless current_user
    @answers = Answer.where user_id: current_user.id
  end

  def new
    m_word = @question.m_words_to_answer.first
    return redirect_to root_path unless m_word
    @answer = Answer.new m_word: m_word, question_id: @question.id
  end

  def create
    @answer.save
    redirect_to new_question_answer_path(@question)
  end

  private
  def load_question
    return redirect_to(root_path) unless params.has_key? :question_id
    @question = current_user.questions.find params[:question_id]
  end

  def build_object
    @answer = Answer.new({question_id: @question.id, user_id: current_user.id}
      .merge(answer_params))
  end

  def answer_params
    if params[:answer]
      params.require(:answer).permit Answer::UPDATABLE_PARAMS
    end
  end
end

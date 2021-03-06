# encoding: utf-8

class AnswersController < ApplicationController
  before_filter :require_admin
  before_filter :get_question

  def new
    @answer = Answer.new
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(params[:answer])
      flash[:success] = "Antwort aktualisiert"
      redirect_to @question
    else
      render 'edit'
    end
  end


  def create
    @answer = Answer.new(params[:answer])
    @answer.question = @question

    if @answer.save
      flash[:success] = "Antwort gespeichert"
      redirect_to @question
    else
      render 'new'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      flash[:success] = "Antwort gelöscht"
    else
      flash[:error] = "Antwort konnte nicht gelöscht werden. Vermutlich steht in den Logs mehr."
    end
    redirect_to @question
  end

  private

  def get_question
    @question = Question.find(params[:question_id])
    unless @question
      flash[:warning] = "Frage mit dieser ID nicht gefunden."
      redirec_to questions_path
    end
  end
end

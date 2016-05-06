class WordsController < ApplicationController
  def index
    @words = Word.study_words.all
  end

  def show
    @word = Word.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])
    @word.known = params[:known] if params[:known].present?
    @word.translation = params[:word][:translation] if params[:word][:translation].present?
    @word.save!
    render json: 'success'
  end
end

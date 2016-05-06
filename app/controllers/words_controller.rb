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

    @word.update_attributes( known: params[:known] )
    render json: 'success'
  end
end

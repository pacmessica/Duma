class WordsController < ApplicationController
  def index
    @study_words = Word.study_words.all
    @known_words = Word.known_words.all
  end

  def show
    @study_word = Word.find(params[:id])
    @known_word = Word.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @study_word = Word.find(params[:id])
    @known_word = Word.find(params[:id])
  end

  def update
    @study_word = Word.find(params[:id])
    @known_word = Word.find(params[:id])
  end
end

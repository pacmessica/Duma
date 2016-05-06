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

    if @study_word.update_attributes( study_word_params )
     redirect_to @study_words
    else
       render 'edit'
    end

    if @known_word.update_attributes( known_word_params )
     redirect_to @known_words
    else
       render 'edit'
    end
  end
end

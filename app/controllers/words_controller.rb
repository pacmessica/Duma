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
    word_params = params.require( :word ).permit( :name, :translation, :known )
    @word = Word.new(word_params)
    if @word.save
      render json: { word: @word }
    else
      render json: { errors: @word.errors, status: :unprocessable_entity }
    end
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])
    @word.known = params[:known] if params[:known].present?
    @word.translation = params[:word][:translation] if params[:word][:translation].present?
    @word.save!
    @word.update_attributes( known: params[:known] )
    render json: 'success'
  end
end

class ArticlesController < ApplicationController
  def index
    @articles = Article.order(title: :asc)
    @tags = Tag.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @tag = Tag.new
  end

  def create
    article_params = params.require( :article ).permit( :title, :content, :image )

    @article = Article.new( article_params )

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    article_params = params.require( :article ).permit( :title, :content, :image )

    if @article.update_attributes( article_params )
      redirect_to @article
    else
      render 'edit'
    end
  end
end

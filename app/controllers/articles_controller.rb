class ArticlesController < ApplicationController
  def index
    @articles = current_user.articles.order(created_at: :desc)
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
    article_params = params.require( :article ).permit( :title, :content, :image, :source )
    @article = Article.new( article_params.merge(user:current_user) )

    if @article.save
      redirect_to articles_path
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

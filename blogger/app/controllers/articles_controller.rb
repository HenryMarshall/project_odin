class ArticlesController < ApplicationController
  include ArticlesHelper

  before_filter :require_login, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @comment = Comment.new
    @article = Article.find(params[:id])
  end

  def new
    # rails uses reflection to figure out the fields of the article
    # it needs a new (not saved) Article instance to `form_for`
    @article = Article.new
  end

  def create
    # Deprecated by helper function
    # @article = Article.new(
    #   title: params[:article][:title],
    #   body:  params[:article][:body])

    # article params is from `app/helpers/articles_helper.rb`
    # Article doesn't have a tags field (many-many relationship)
    # this causes an error -- added `tag_list=(tags_string)` to article.rb
    @article = Article.new(article_params)
    @article.save
    flash.notice = "Article '#{@article.title}' Created!"
    redirect_to article_path(@article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    flash.notice = "Article '#{@article.title}' Updated!"
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id]).destroy
    flash.notice = "Article '#{@article.title}' Destroyed!"
    redirect_to articles_path
  end

end

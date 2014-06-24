class CommentsController < ApplicationController
  # other methods not implemented, but to future proof security
  before_filter :require_login, except: [:create]

  include CommentsHelper

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    @comment.save
    flash.notice = "Comment Created!"
    redirect_to article_path(@comment.article)
  end
end

class CommentsController < ApplicationController
  before_action :authorize
  before_action :load_comment, only: %i(edit update destroy)
  before_action :verify_owner, only: %i(update destroy)
  
  delegate :comment_id, to: :@comment, allow_nil: true
  
  helper_method :comment_id
  
  def create
    @article = Article.find params[:article_id]
    
    @comment = @article
                 .comments.create comment_params.merge(user: current_user)
  end
  
  def edit
  end
  
  def update
    @comment.update comment_params
  end
  
  def destroy
    @comment.destroy
  end
  
  private
  
  def load_comment
    @comment = Comment.find params[:id]
  end
  
  def comment_params
    params.require(:comment).permit :body, :comment_id
  end
  
  def verify_owner
    return if my_item? @comment
    
    raise ActionController::RoutingError.new('Not Found')
  end
end

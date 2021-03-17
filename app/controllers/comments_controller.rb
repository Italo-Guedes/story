class CommentsController < ApplicationController
  include Behaveable::ResourceFinder
  include Behaveable::RouteExtractor
  
  respond_to :json, except: [:destroy]

  def index
    @comments = commenteable
    if params[:from].present?
      @comments = commenteable.order(id: :asc).where('id > ?', params[:from]).limit(20)
    else
      @comments = commenteable.order(id: :desc).limit(20).reverse

      if params[:until].present?
        # @comments = @comments.where('id < ?', params[:until])
        @comments = commenteable.where('id < ?', params[:until]).limit(20)
      end
    end
    # respond_with @comments, status: :ok, location: extract(@behaveable)
    respond_to do |format|
      format.json { render json: Oj.dump(@comments.as_json(), mode: :compat), status: :created }
    end
  end

  def create
    @comment = commenteable.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.json { render json: Oj.dump(@comment.as_json(), mode: :compat), status: :created }
      else
        format.json { render errors_for(@comment) }
      end
    end
  end

  def destroy
    @comment = commenteable.find(params[:id])
    @comment.destroy if @comment
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to :back }
    end
  end

  private

  def commenteable
    @behaveable ||= behaveable
    @behaveable ? @behaveable.comments : Comment
  end

  def errors_for(object)
    { json: { errors: object.errors }, status: :unprocessable_entity }
  end
  
  def comment_params
    params.require(:comment).permit(:text)
  end
end
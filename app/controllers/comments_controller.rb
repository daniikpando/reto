class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_article
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:destroy]
  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.product = @product
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @product, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render @product }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
        format.html { redirect_to @product, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private
    def set_article
        @product = Product.find(params[:product_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
        @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
        params.require(:comment).permit(:comment_user, :user_id, :like_comment, :dislike)
    end
end

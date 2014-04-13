#
# コメントコントローラ。
#
class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_diary, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @diary.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        DiaryNotifier.add_comment(@diary, @comment).deliver if current_user != @diary.user

        format.html { redirect_to @diary, notice: I18n.t('helpers.notice.success.create', { model: Comment.model_name.human }) }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment.user = current_user
    @comment.diary = @diary

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @diary, notice: I18n.t('helpers.notice.success.update', { model: Comment.model_name.human }) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @diary, notice: I18n.t('helpers.notice.success.destroy', { model: Comment.model_name.human }) }
      format.json { head :no_content }
    end
  end

  private
    def set_diary
      @diary = Diary.find(params[:diary_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:contents, :diary_id, :user_id)
    end
end

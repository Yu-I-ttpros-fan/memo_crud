class MemosController < ApplicationController
  def index
    # ユーザごとにメモ一覧を表示させる
    @memos = current_user.created_memos.all.order(created_at: :desc)
  end

  def new
    @memo = current_user.created_memos.build
  end

  def create
    @memo = current_user.created_memos.build(memo_params)

    if @memo.save
      redirect_to memos_path, notice: '新規メモを登録しました'
    else
      failure_save
    end
  end

  def edit
    @memo = current_user.created_memos.find(params[:id])
  end

  def update
    @memo = current_user.created_memos.find(params[:id])
    if @memo.update(memo_params)
      redirect_to memos_path, notice: 'メモを更新しました'
    else
      failure_save
    end
  end

  private

  def memo_params
    params.require(:memo).permit(
      :title, :content
    )
  end

  def failure_save
    render :new, status: :unprocessable_entity
  end
end

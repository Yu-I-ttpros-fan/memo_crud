class MemosController < ApplicationController
  def index
    # メモ一覧を表示させる
  end

  def new
    @memo = current_user.create_memos.build
  end

  def create
    @memo = current_user.create_memos.build(memo_params)

    if @memo.save
      redirect_to memos_path, notice: '新規メモを登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def memo_params
    params.require(:memo).permit(
      :title, :content
    )
  end
end

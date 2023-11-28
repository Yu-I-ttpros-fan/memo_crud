class MemosController < ApplicationController
  def index
    @memos = Memo.memo_display(params,current_user)
    @genres = Genre.all
    @selected_genre_id = params[:genre_id].presence
  end

  def new
    @memo = current_user.created_memos.build
  end

  def create
    @memo = current_user.created_memos.build(memo_params)
    set_genre_id_from_params

    if @memo.save
      redirect_to memos_path, notice: '新規メモを登録しました'
    else
      failure_save
    end
  end

  def edit
    @memo = current_user.created_memos.find(params[:id])
    @selected_genre_id = @memo.genre_id
  end

  def update
    @memo = current_user.created_memos.find(params[:id])
    set_genre_id_from_params
    if @memo.update(memo_params)
      redirect_to memos_path, notice: 'メモを更新しました'
    else
      failure_save
    end
  end

  def destroy
    @memo = current_user.created_memos.find(params[:id])
    @memo.destroy!
    redirect_to memos_path, notice: '削除しました', status: :see_other
  end

  private

  def memo_params
    params.require(:memo).permit(
      :title, :content, :genre_id, :commit
    )
  end

  def failure_save
    render :new, status: :unprocessable_entity
  end

  def set_genre_id_from_params
    # 編集、登録画面でのジャンルの登録
    @memo.genre_id = params[:memo][:genre_id] if params[:memo][:genre_id].present?
  end
end

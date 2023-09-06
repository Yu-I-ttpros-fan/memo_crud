class MemosController < ApplicationController
  def index
    @memos = memo_display
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

  def memo_display
    # 表示しやすいように機能を追加しやすいように処理を切り出し
    # 並び替えの処理
    order_rule = params[:order_rule].present? ? params[:order_rule] : 'created_at'
    order_time = params[:order_time].present? ? params[:order_by] : 'desc'

    memos = current_user.created_memos.order("#{order_rule} #{order_time}")

    # ジャンルで表示数を絞る
    memos = memos.where(genre_id: params[:genre_id]).order("#{order_rule} #{order_time}") if params[:genre_id].present?

    memos
  end
end

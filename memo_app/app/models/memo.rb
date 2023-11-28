class Memo < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 500 }, presence: true

  def self.memo_display(params,current_user)
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

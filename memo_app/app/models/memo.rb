class Memo < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 500 }, presence: true
end

class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image
  validates :price, numericality: { greater_than_or_equal_to: 1, message: "は1円以上で入力してください" }
  # validates :area, presence: true, inclusion: { in: ["東京", "大阪", "京都", "札幌"] }
end

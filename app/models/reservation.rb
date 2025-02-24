class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # スコープを追加：仮予約の状態
  scope :pending, -> { where(status: 'pending') }
  # スコープを追加：確定予約の状態
  scope :confirmed, -> { where(status: 'confirmed') }

  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :guest_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :check_out_after_check_in
  validate :check_in_date_cannot_be_in_the_past
  # validates :price_per_night, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def nights
    (check_out_date - check_in_date).to_i
  end

  def confirm!
    update(confirmed: true)
  end

  def total_price
    room.price  *  nights * guest_count
  end

  private

  def check_out_after_check_in
    if check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日より後の日付を選んでください")
    end
  end

  # チェックイン日が本日以降であることを確認するバリデーション
  def check_in_date_cannot_be_in_the_past
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "は本日以降の日付を選んでください")
    end
  end
end

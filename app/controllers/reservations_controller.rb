class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:edit, :update, :destroy,]

  def index
    @reservations = current_user.reservations.includes(:room)
    @rooms = Room.includes(:reservations).where.not(reservations: { status: 'pending' })
    @reservations = current_user.reservations.where.not(status: 'pending').includes(:room)
  end

  def new
    @room = Room.find(params[:room_id]) # 部屋情報の取得
    @reservation = @room.reservations.new
  end
  
  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user
    @reservation.status = 'pending'  # 仮予約として保存
  
    if @reservation.save  # 一時保存（仮予約）
      redirect_to room_reservation_path(@room, @reservation)  # 予約詳細ページへリダイレクト
    else
      render :new  # 保存に失敗した場合は新規作成画面を再表示
    end
  end

  def show
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.find(params[:id])  # 予約詳細の表示
  end

  def confirm
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.find(params[:id])
  
    # 仮予約を確定予約に更新
    if @reservation.update(status: 'confirmed')  # 確定処理
      flash[:alert] = "予約が確定しました"
      redirect_to reservations_path
    else
      flash[:alert] = "予約の確定に失敗しました。"
      render :show  # 更新に失敗した場合、確認画面に戻る
    end
  end
    
  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to room_reservation_path(@reservation.room, @reservation), notice: '予約を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to room_reservations_path(@reservation.room), notice: '予約を削除しました。'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id]) # 全ての予約から指定された予約を取得
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :guest_count)
  end
end

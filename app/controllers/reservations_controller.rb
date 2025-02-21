class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy, :confirm]

  def index
    @reservations = current_user.reservations.includes(:room)
  end

  def show
  end

  def new
    @room = Room.find(params[:room_id]) # 部屋情報の取得
    @reservation = @room.reservations.new
  end
  
  def create
    @room = Room.find(params[:room_id]) # 部屋情報の取得
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user
    if @reservation.save
      redirect_to room_reservation_path(@room, @reservation), notice: '予約が確定しました。'
    else
      render :new, notice: '予約が失敗しました'
    end
  end  
    
  def confirm
    if @reservation.update(confirmed: true)
      redirect_to room_reservations_path(@reservation.room), notice: "予約が確定しました。" 
    else
      flash[:alert] = "予約の確定に失敗しました。"
      render :show
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

class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [ :edit, :update, :destroy]

  def index
    @rooms = current_user.rooms
  end
  
   # 施設検索結果ページ
  def search
    @rooms = nil
  
    # キーワード検索
    if params[:q].present?
      @rooms = @rooms.where("name LIKE ? OR details LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    else
      @rooms = Room.none  
    end
  
    # エリア検索
    if params[:area].present?
      valid_areas = ["東京", "大阪", "京都", "札幌"]
      if valid_areas.include?(params[:area])
        @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
      else
        @rooms = Room.none  
      end
    end

    # 検索結果の件数を取得
    @total_rooms = @rooms.count
  end
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user # 明示的に current_user を設定
    if @room.save
      redirect_to room_path(@room), notice: '部屋が作成されました'
    else
      render :new
    end
  end
  

  def show
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to room_path(@room), notice: '部屋が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: '部屋が削除されました'
  end

  private

  # 共通処理: ID から `@room` を取得
  def set_room
    @room = Room.find(params[:id])
  end

  # ユーザーがこの部屋のオーナーかチェック
  def authorize_user
    unless @room.user == current_user
      redirect_to rooms_path, alert: 'この部屋はあなたのものではありません'
    end  
  end

  # Strong Parameters
  def room_params
    params.require(:room).permit(:name, :details, :price, :image, :address, :area)
  end
end

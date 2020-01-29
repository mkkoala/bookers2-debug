class ChatsController < ApplicationController
  before_action :authenticate_user!


  def show
    #binding.pry
    @user = User.find(params[:user_id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms )
    if user_rooms #もし、user_roomsが存在したら
    	@room = user_rooms.room
    else
    	@room = Room.new(name: @user.name + 'さんと' + current_user.name )
    	@room.save
    	UserRoom.create(user_id: current_user.id, room_id: @room.id)
    	UserRoom.create(user_id: @user.id, room_id: @room.id)

	end
    @chats = @room.chats.recent.limit(10).reverse
  end
end

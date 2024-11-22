class RoomMessagesController < ApplicationController
    before_action :load_entities
    protect_from_forgery with: :null_session
  
    def create
    
      @room_message = RoomMessage.create user: current_user,
                                         room: @room,
                                         message: params.dig(:room_message, :message)
  
     RoomChannel.broadcast_to @room, @room_message
    end
  
    protected
  
    def load_entities
      @room = Room.find params.dig(:room_message, :room_id)
    end
  end
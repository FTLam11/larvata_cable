module LarvataCable
  class MessagesController < ApplicationController
    def index
      # TODO: verify user is a member of requested chat room?

      auth_service = AuthorizeHost.new(params)

      if auth_service.success
        options = { page: message_params[:page], per: message_params[:per] }
        messages = Message.for_room(params[:chat_room_id], options)

        render json: { messages: messages }
      else
        render json: { error: auth_service.error }, status: 400
      end
    end

    private

    def message_params
      params.permit(:page, :per)
    end
  end
end

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include LarvataCable::UserFindable

    identified_by :current_user

    def connect
      self.current_user = set_user
      logger.add_tags 'Action Cable', "User #{current_user.id}"
    end

    private

    def set_user
      find_verified_user || reject_unauthorized_connection
    end
  end
end

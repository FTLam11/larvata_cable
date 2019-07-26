module LarvataCable
  class ChatRoom < ApplicationRecord
    belongs_to :owner, class_name: 'User'

    validates_presence_of :owner_id
  end
end

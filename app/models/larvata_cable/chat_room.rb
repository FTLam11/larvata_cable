module LarvataCable
  class ChatRoom < ApplicationRecord
    belongs_to :owner, class_name: 'User'
  end
end

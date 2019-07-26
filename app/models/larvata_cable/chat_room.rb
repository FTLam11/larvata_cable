module LarvataCable
  class ChatRoom < ApplicationRecord
    belongs_to :owner, class_name: LarvataCable.user_class
  end
end

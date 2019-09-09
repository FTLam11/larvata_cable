module LarvataCable
  class ChatRoom < ApplicationRecord
    belongs_to :owner, class_name: 'LarvataCable::User'
    belongs_to :tenant, class_name: 'LarvataCable::Tenant'
    has_many :chatters, foreign_key: 'larvata_cable_chat_room_id'
    has_many :members, through: :chatters, source: 'user'
    has_many :messages, -> { order(:created_at) }, foreign_key: 'larvata_cable_chat_room_id'

    # TODO: is name required? examine use cases

    after_commit :add_owner_to_members

    def as_json(*)
      super(only: [:id, :name, :created_at]).tap do |hash|
        hash[:owner_id] = owner.host_user_id
        hash[:app_id] = tenant_id
        hash[:member_ids] = members.pluck(:host_user_id)
      end
    end

    private

    def add_owner_to_members
      members << owner unless members.include?(owner)
    end
  end
end

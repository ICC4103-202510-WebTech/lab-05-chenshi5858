class Chat < ApplicationRecord
    validates :sender_id, presence: true
    validates :receiver_id, presence: true
    validate :sender_and_receiver_are_different

    belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
    belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
    has_many :messages, dependent: :destroy

    scope :for_user, ->(user) { where("sender_id = ? OR receiver_id = ?", user.id, user.id) }
    def other_participant(user)
        user.id == sender_id ? receiver : sender
    end
    private
    def sender_and_receiver_are_different
        if sender_id == receiver_id
        errors.add(:receiver_id, "must be different from sender_id")
        end
    end
end
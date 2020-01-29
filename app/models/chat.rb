class Chat < ApplicationRecord
	belongs_to :user
	belongs_to :room

	validates :message, presence: true
    scope :recent, -> { order(created_at: :desc)}
end

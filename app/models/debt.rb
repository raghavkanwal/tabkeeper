class Debt < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :to, presence: true, length: { maximum: 30 }
end

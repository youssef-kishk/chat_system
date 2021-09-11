class Chat < ApplicationRecord
    belongs_to :application
    validates :number, presence: true
    has_many :messages
end

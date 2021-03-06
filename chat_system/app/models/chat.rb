class Chat < ApplicationRecord
    belongs_to :application
    validates :number, presence: true
    has_many :messages, dependent: :delete_all

    validates :number, uniqueness: { scope: :application }
end

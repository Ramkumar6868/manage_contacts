class ContactList < ApplicationRecord
	has_many :contact_list_mappings
	has_many :contacts, through: :contact_list_mappings,  dependent: :destroy

	validates :name, presence: true, uniqueness: true, length: {minimum: 3, maximum: 255}
end

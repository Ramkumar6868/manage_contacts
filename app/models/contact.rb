class Contact < ApplicationRecord
	has_many :contact_list_mappings
	has_many :contact_lists, through: :contact_list_mappings, dependent: :destroy

	validates :name, presence: true, length: {minimum: 3}
	validates :email, presence: true, uniqueness: true, format: {with: /((!|[#-.]|[0-?]|[A-~])+@(!|[#-.]|[0-?]|[A-~])+\.(!|[#-.]|[0-?]|[A-~])+)/i, message: "Email is not valid"}
end

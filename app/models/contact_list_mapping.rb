class ContactListMapping < ApplicationRecord
  belongs_to :contact
  belongs_to :contact_list
end

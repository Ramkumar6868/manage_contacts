require 'test_helper'

class ContactListTest < ActiveSupport::TestCase
	test "should not save contact-list without name" do
	  contactList = ContactList.new
	  assert_not contactList.save, "Save contact-list without name"
	end

	test "should not save contact-list with length of name less than 3" do
	  contactList = ContactList.new
	  contactList.name = "my"
	  assert_not contactList.save, "Save contact-list with length of name less than 3"
	end

	test "should save contact-list" do
	  contactList = ContactList.new
	  contactList.name = "my name"
	  assert contactList.save, "Save contact!"
	end

	test "should save contact-list " do
	  contactList = ContactList.new
	  contactList.name = "my name"
	  assert contactList.save, "Save contact-list with length of name less than 3"
	end

	test "contactList can have many contacts" do
		cont = contact_lists(:one).contacts
		assert_equal 2, cont.count, "contact-list cann't have many contacts"
	end

 	 
end


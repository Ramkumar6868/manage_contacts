require 'test_helper'

class ContactTest < ActiveSupport::TestCase
	test "should not save contact without name" do
	  contact = Contact.new
	  contact.email = "am@gmail.com"
	  assert_not contact.save, "Save contact without name"
	end

	test "should not save contact without email" do
	  contact = Contact.new
	  contact.name = "valid name"
	  assert_not contact.save, "Save contact without email"
	end

	test "should not save contact invalid email" do
	  contact = Contact.new
	  contact.name = "valid name"
	  contact.email = "aaa@"
	  assert_not contact.save, "Save invalid email address"
	end

	test "Name length for contact must be 3" do
	  contact = Contact.new
	  contact.name = "cc"
	  contact.email = "abc@gmail.com"
	  assert_not contact.save, "Contact name saved for 3 length name"
	end

	test "should save valid contact" do
	  contact = Contact.new
	  contact.name = "valid name"
	  contact.email = "validemail@gmail.com"
	  assert contact.save, "Should save valid details for contact"
	end

	test "contacts can have many contacts" do
		cont = contacts(:one).contact_lists
		assert_equal 2, cont.count, "contacts cann't have many contacts"
	end
end

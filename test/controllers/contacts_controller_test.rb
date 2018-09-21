require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get show of contact" do
    cont = Contact.new
    cont.name = "my name"
    cont.email = "Avjs@gmail.com"
    assert cont.save, "Contact not saved"
    get contact_path(cont)
    assert_response :success
  end

  test "should get index for contact" do
    get contacts_path
    assert_response :success
  end

  test "can create contact" do
    get new_contact_path
    assert_response :success
    post "/contacts", params: {contact: {name: "testName", email: "abc@gmail.com"}}
    assert_response :redirect , "not redirected after create"
    assert_equal "testName", Contact.last.name, "contact can't save"
    follow_redirect!
    assert_response :success
  end

  test "can update contact" do
    cont = Contact.new
    cont.name = "my name"
    cont.email = "abc@gmail.com"
    assert cont.save, "Cann't save contact"
    get edit_contact_path(cont)
    assert_response :success
    put "/contacts/"+cont.id.to_s, params: {contact: {name: "testName", email: "sss@mmm.com"}}
    assert_equal "testName", Contact.find(cont.id).name, "name not updated"
    assert_equal "sss@mmm.com", Contact.find(cont.id).email, "email not updated"
    assert_response :redirect, "redirection after update"
    follow_redirect!
    assert_response :success
  end

  test "can destroy contact" do
    cont = Contact.new
    cont.name = "my name"
    cont.email = "abc@gmail.com"
    assert cont.save, "Cann't save contact"
    delete "/contacts/"+cont.id.to_s
    assert_raise(StandardError){ Contact.find(cont.id)}
    assert_response :redirect, "redirection after delete"
    follow_redirect!
    assert_response :success
  end

end

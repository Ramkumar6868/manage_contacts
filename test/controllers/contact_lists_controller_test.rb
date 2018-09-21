require 'test_helper'

class ContactListsControllerTest < ActionDispatch::IntegrationTest
  test "should get show of contact_list" do
    cont = ContactList.new
    cont.name = "my name"
    assert cont.save, "Contact-list not saved"
    get contact_list_path(cont)
    assert_response :success
  end

  test "should get index for contact-list" do
    get contact_lists_path
    assert_response :success
  end

  test "can create contact-list" do
    get new_contact_list_path
    assert_response :success
    post "/contact_lists", params: {contact_list: {name: "testName"}}
    assert_response :redirect , "not redirected after create"
    follow_redirect!
    assert_response :success
  end

  test "can update contact-list" do
    cont = ContactList.new
    cont.name = "my name"
    assert cont.save
    get edit_contact_list_path(cont)
    assert_response :success
    put "/contact_lists/"+cont.id.to_s, params: {contact_list: {name: "testName"}}
    assert_response :redirect, "redirection after update"
    follow_redirect!
    assert_response :success
  end

  test "can destroy contact-list" do
    cont = ContactList.new
    cont.name = "my name"
    assert cont.save, "Cann't save contact-list"
    delete "/contact_lists/"+cont.id.to_s
    assert_raise(StandardError){ ContactList.find(cont.id)}
    assert_response :redirect, "redirection after delete"
    follow_redirect!
    assert_response :success
  end

end

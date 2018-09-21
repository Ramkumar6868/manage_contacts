require 'rails_helper'

RSpec.describe ContactListsController, type: :controller do
	
	after :each do 
		ContactList.destroy_all
		Contact.destroy_all
	end

	describe "POST create" do
	  context "with valid attributes" do

	    it "creates a new contact-list" do
	      expect{
	        post :create, params: {contact_list: {name: "sasaa"}}
	      }.to change(ContactList,:count).by(1)
	    end
	    
	    it "redirects to the new contact-list" do
	      post :create, params: {contact_list: {name: "s1asaa"}}
	      response.should redirect_to ContactList.last
	    end
	  end
	end

	describe "DELETE destroy" do
	    before :each do
		    @contactList = ContactList.create!({name: "tmp1"})
		end

	    it 'should delete' do
	        expect{
		    	delete :destroy, params: {id: @contactList.id}
		    }.to change(ContactList,:count).by(-1)
	    end
	end


	describe 'PUT update' do
	  before :each do
	    @contactList = ContactList.create({name: "tmp1"})
	  end
	  
	  context "valid attributes" do
	    it "located the requested @contact-list" do
	      put :update, params: {id: @contactList.id, contact_list: {name: "Lawrence3 by change"}}
	      @contactList.reload
	      assigns(:contactList).should eq(@contactList)      
	    end
	  
	    it "changes @contact-list's attributes" do
	      put :update, params: {id: @contactList.id, 
	        contact_list: {name: "ggg"}}

	      @contactList.reload
	      @contactList.name.should eq("ggg")
	    end
	  
	    it "redirects to the updated contact-list" do
	      put :update, params: {id: @contactList.id, contact_list: {name: "ggg2"}}
	      response.should redirect_to @contactList
	    end
	  end
	  
	  context "invalid attributes" do
	    it "locates the requested @contact-list" do
	      put :update, params: {id: @contactList.id, contact_list: {mm: "ss1"}}
	      assigns(:contactList).should eq(@contactList)      
	    end
	    
	    it "does not change @contact-list's attributes" do
	      put :update, params: {id: @contactList.id, 
	        contact_list: {firstname: "Larry2", email: nil}}
	      @contactList.reload
	      @contactList.name.should_not eq("Larry2")
	    end
	  end
	end

	describe "GET new contacts" do
	    before :each do
		    @contactList = ContactList.create(name: "tmp1")
		    @contactList.contacts << Contact.new({name: "contact1", email: "email1@email.com"})
		    @contactList.save
		    contact = Contact.create({name: "contact2", email: "email2@email.com"})
		    @contacts = [contact]
		end

	    it 'should get contacts' do
	        get :new_contact, params: {contact_list_id: @contactList.id}
		    assigns(:contacts).should eq(@contacts)
	    end
	end

	describe "POST add contacts" do
	    before :each do
		    @contactList = ContactList.create(name: "tmp1")
		    @contact = Contact.create({name: "contact2", email: "email2@email.com"})
		    
		end

	    it 'should Post contacts' do
	        post :add_contact, params: {contact_list_id: @contactList.id, contact_list:{contact_ids: @contact.id}}
		    assigns(:contact).should eq(@contactList.contacts.first)
	    end
	end

	describe "GET contacts for contact-list in JSON" do
	    before :each do
		    @contactList = ContactList.create(name: "tmp1")
		    @contactList.contacts <<  Contact.new({name: "contact2", email: "email2@email.com"})
		    @contactList.contacts << Contact.new({name: "contact1", email: "email1@email.com"})
		    @contactList.save
		    
		end


	    it 'should GET contacts' do
	        get :contacts_for_contact_list, params: {contact_list_id: @contactList.id}
		    response.body.should == {
		    	contact_list_name: "tmp1",
		    	contacts: [
		    		{id: @contactList.contacts.first.id, email: "email2@email.com", name: "contact2"},
		    		{id: @contactList.contacts.last.id, email: "email1@email.com", name: "contact1"},
		    	]
		    }.to_json
	    end
	end

end
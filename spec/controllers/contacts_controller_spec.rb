require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
	after :each do 
		Contact.destroy_all
	end
	describe "POST create" do
	  context "with valid attributes" do
	    it "creates a new contact" do
	      expect{
	        post :create, params: {contact: {name: "sasaa", email: "email3@gmai.com"}}
	      }.to change(Contact,:count).by(1)
	    end
	    
	    it "redirects to the new contact" do
	      post :create, params: {contact: {name: "s1asaa", email: "email4@gmai.com"}}
	      response.should redirect_to Contact.last
	    end
	  end
	end
	
	describe "DELETE destroy" do
	    before :each do
		    @contact = Contact.create({name: "sasaa", email: "email3@gmai.com"})
		end

	    it 'should delete' do
	        expect{
		    	delete :destroy, params: {id: @contact.id}
		    }.to change(Contact,:count).by(-1)
	    end
	end


	describe 'PUT update' do
	  before :each do
	    @contact = Contact.create({name: "sasaa", email: "email3@gmai.com"})
	  end
	  
	  context "valid attributes" do
	    it "located the requested @contact" do
	      put :update, params: {id: @contact.id, contact: {name: "Lawrence", email: "smith@2gmail.com"}}
	      assigns(:contact).should eq(@contact)      
	    end
	  
	    it "changes @contact's attributes" do
	      put :update, params: {id: @contact.id, 
	        contact: {name: "Larry", email: "smith@gmail.com"}}

	      @contact.reload
	      @contact.name.should eq("Larry")
	      @contact.email.should eq("smith@gmail.com")
	    end
	  
	    it "redirects to the updated contact" do
	      put :update, params: {id: @contact.id, contact: {name: "Lawrence", email: "smith@gmail.com"}}
	      response.should redirect_to @contact
	    end
	  end
	  
	  context "invalid attributes" do
	    it "locates the requested @contact" do
	      put :update, params: {id: @contact.id, contact: {mm: "ss"}}
	      assigns(:contact).should eq(@contact)      
	    end
	    
	    it "does not change @contact's attributes" do
	      put :update, params: {id: @contact.id, 
	        contact: {firstname: "Larry", email: nil}}
	      @contact.reload
	      @contact.name.should_not eq("Larry")
	      @contact.email.should eq("email3@gmai.com")
	    end
	  end
	end

end
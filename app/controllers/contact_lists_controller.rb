class ContactListsController < ApplicationController
    def new
        @contactList = ContactList.new
    end

    def create
        @contactList = ContactList.new(filter_params)
        if @contactList.save
            redirect_to @contactList
        else
            render 'new'
        end
    end

    def update
        @contactList = ContactList.find(params[:id])
        if @contactList.update(filter_params)
            redirect_to @contactList
        else
            render 'edit'
        end
    end

    def edit
        @contactList = ContactList.find(params[:id])
    end

    def destroy
        @contactList = ContactList.find(params[:id])
        @contactList.destroy

        redirect_to contact_lists_path
    end

    def index
        @contact_lists = ContactList.all
    end

    def show
        @contactList = ContactList.find(params[:id]) 
    end

    def contacts_for_contact_list
        @contactList = ContactList.find(params[:contact_list_id])
        render json: {contact_list_name: @contactList.name, contacts: @contactList.contacts.select('contact_id as id, name, email')}
    end

    def new_contact
        @contactList = ContactList.find(params[:contact_list_id])
        cont = @contactList.contacts.map{|c| c.id}
        @contacts = Contact.where.not(id: cont)
    end

    def add_contact
        @contactList = ContactList.find(params[:contact_list_id])
        @contact = Contact.find(params[:contact_list][:contact_ids])
        if @contactList.contacts << @contact
            redirect_to contact_lists_path(@contactList)
        else
            render contact_list_new_contact_path
        end
    end
    private

    def filter_params
        params.require(:contact_list).permit(:name)
    end
end

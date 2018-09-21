require 'rails_helper'


describe Contact, type: :model  do
  	describe "validations" do
        let(:contact_list) { ContactList.new({name: "valid_attr"}) }

        before do
            ContactList.create({name: "valid_attr"})
        end

	   	it { is_expected.to  validate_presence_of(:name)}
	   	it { is_expected.to  validate_length_of(:name).is_at_least(3).with_message("is too short (minimum is 3 characters)")}
    end

    describe "ActiveRecord" do
        let(:contact_list) { ContactList.new({name: "valid_attr"}) }

        before do
            ContactList.create({name: "valid_attr"})
        end

        it { expect(contact_list).to  have_many(:contacts)}
    end
end
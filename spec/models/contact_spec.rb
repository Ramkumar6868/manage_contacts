require 'rails_helper'


describe Contact, type: :model  do
  	describe "validations" do
        let(:contact) { Contact.new({name: "valid_attr", email: "abc@gmail.com"}) }

        before do
            Contact.create({name: "valid_attr", email: "abc@gmail.com"})
        end

	   	it { is_expected.to  validate_presence_of(:name)}
	   	it { is_expected.to  validate_presence_of(:email)}
	   	it { is_expected.to  validate_length_of(:name).is_at_least(3).with_message("is too short (minimum is 3 characters)")}

        it "requires an email" do
            expect(contact).to validate_presence_of(:email)
        end

        it "requires a unique email" do
            expect(contact).to validate_uniqueness_of(:email)
        end

        it "requires the email to look like an email" do
            contact.email = "brown"
            expect(contact).to_not be_valid
        end
    end

    describe "ActiveRecord" do
        let(:contact) { Contact.new({name: "valid_attr", email: "acs@gmail.com"}) }

        before do
            Contact.create({name: "valid_attr", email: "acs@gmail.com"})
        end

        it { expect(contact).to  have_many(:contact_lists)}
    end
end
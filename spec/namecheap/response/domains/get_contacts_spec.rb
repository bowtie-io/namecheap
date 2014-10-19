require 'spec_helper'

describe Namecheap::Response::Domains::GetContacts do
  subject(:contacts)     { described_class.new contact_response }
  let(:contact_response) { File.read './spec/fixtures/get_contacts_response.xml' }

  describe '#initialize' do
    it 'builds a hash of contacts' do
      expect(contacts.contacts).to be_a Hash
    end
  end
end

require 'spec_helper'

describe Namecheap::Response::Contact do
  subject(:contact)  { described_class.new type, nodes }
  let(:type)         { 'Tech' }
  let(:contact_file) { File.read './spec/fixtures/get_contacts_response.xml' }
  let(:contacts)     { Namecheap::Response::Processor.new(contact_file) }
  let(:nodes) do
    list = contacts.response.xpath('//xmlns:DomainContactsResult')

    list.children[1].children
  end

  describe '#initialize' do
    it 'sets the contact type' do
      expect(contact.type).to eq 'Tech'
    end

    it 'populates the contact from the given nodes' do
      expect(contact.first_name).to eq 'John'
    end
  end
end

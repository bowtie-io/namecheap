require 'spec_helper'

describe Namecheap::Response::Domains::GetList do
  subject(:list)      { described_class.new list_response }
  let(:list_response) { File.read './spec/fixtures/get_list_response.xml' }
  let(:processed) do
    {
      "domain1.com" => {
        "ID"=>"127",
        "Name"=>"domain1.com",
        "User"=>"owner",
        "Created"=>"02/15/2014",
        "Expires"=>"02/15/2020",
        "IsExpired"=>"false",
        "IsLocked"=>"false",
        "AutoRenew"=>"false",
        "WhoisGuard"=>"ENABLED"
      },
      "domain2.com" => {
        "ID"=>"381",
        "Name"=>"domain2.com",
        "User"=>"owner",
        "Created"=>"04/28/2014",
        "Expires"=>"04/28/2021",
        "IsExpired"=>"false",
        "IsLocked"=>"false",
        "AutoRenew"=>"true",
        "WhoisGuard"=>"NOTPRESENT"
      }
    }
  end

  describe '#initialize' do
    it 'builds the domain list' do
      expect(list.list).to eq processed
    end

    it 'sets the page number' do
      expect(list.page).to eq 1
    end

    it 'sets the page size' do
      expect(list.page_size).to eq 10
    end

    it 'sets the total length' do
      expect(list.total_length).to eq 2
    end
  end
end

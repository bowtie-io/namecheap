require 'spec_helper'

describe Namecheap::Response::Domains::Create do
  subject(:create_parser)   { described_class.new domain_response }
  let(:domain_response)     { File.read './spec/fixtures/create_response.xml' }
  let(:domain)              { 'domain1.com' }
  let(:charged_amount)      { 20.3600 }
  let(:domain_id)           { '9007' }
  let(:order_id)            { '196074' }
  let(:transaction_id)      { '380716' }
  let(:whoisguard_enabled)  { false }
  let(:non_realtime_domain) { false }

  describe '#initialize' do
    it 'sets the domain attribute' do
      expect(create_parser.domain).to eq domain
    end

    it 'sets the charged_amount' do
      expect(create_parser.charged_amount).to eq charged_amount
    end

    it 'sets the domain_id' do
      expect(create_parser.domain_id).to eq domain_id
    end

    it 'sets the order_id' do
      expect(create_parser.order_id).to eq order_id
    end

    it 'sets the transaction_id' do
      expect(create_parser.transaction_id).to eq transaction_id
    end

    it 'indicates whether or not whoisguard is enabled' do
      expect(create_parser.whoisguard_enabled?).to eq whoisguard_enabled
    end

    it 'indicates whether or not it is a realtime domain' do
      expect(create_parser.non_realtime_domain?).to eq non_realtime_domain
    end
  end

  describe '#successful?' do
    it 'returns true if the response indicates success' do
      expect(create_parser.successful?).to be true
    end
  end
end

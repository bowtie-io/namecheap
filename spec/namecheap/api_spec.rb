require 'spec_helper'

require './lib/namecheap/api.rb'

describe Namecheap::Api do
  subject(:api) { described_class.new }

  describe '#response_processor' do
    it 'returns a constant when given a command with a matching procesor' do
      expect(api.response_processor('domains.getList')).to eq Namecheap::Response::Domains::GetList
    end

    it 'returns nil when given a command without a matching processor' do
      expect(api.response_processor('domains.nuke')).to be nil
    end
  end
end

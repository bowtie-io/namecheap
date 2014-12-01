require 'spec_helper'

describe Namecheap::Response::Domains::Check do
  subject(:check)      { described_class.new check_response }
  let(:check_response) { File.read './spec/fixtures/check_response.xml' }
  let(:availability) do
    {
      'domain1.com' => 'true',
      'availabledomain.com' => 'false'
    }
  end

  describe '#initialize' do
    it 'sets the domain from the response' do
      expect(check.availability).to eq availability
    end
  end

  describe '#available?' do
    it 'returns true if the domain is available' do
      free = check.available? 'domain1.com'

      expect(free).to be_truthy
    end

    it 'returns false if the domain is not available' do
      free = check.available? 'availabledomain.com'

      expect(free).to be_falsy
    end
  end
end

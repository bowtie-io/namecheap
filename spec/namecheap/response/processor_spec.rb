require 'spec_helper'

describe Namecheap::Response::Processor do
  subject(:processor) { described_class }
  let(:success_body)  { File.read './spec/fixtures/success_body.xml' }
  let(:error_body)    { File.read './spec/fixtures/error_response.xml' }
  let(:error_message) { 'Parameter ClientIP is missing' }

  describe '#initialize' do
    it 'parses the response' do
      response = processor.new(success_body).response

      expect(response).to be_a_kind_of Nokogiri::XML::Document
    end

    context 'error_response' do
      before do
        @response = processor.new(error_body)
      end

      it 'finds errors' do
        expect(@response.errors).to include error_message
      end

      it 'indicates that the request was bad' do
        expect(@response.bad_request).to be true
      end
    end

    context 'non error response' do
      it 'sets errors to an empty array' do
        errors = processor.new(success_body).errors

        expect(errors).to eq []
      end
    end
  end
end

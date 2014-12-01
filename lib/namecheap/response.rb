require 'nokogiri'

require_relative 'response/processor.rb'
require_relative 'response/domains/create.rb'
require_relative 'response/domains/check.rb'
require_relative 'response/domains/get_list.rb'
require_relative 'response/domains/get_contacts.rb'
require_relative 'response/contact.rb'

module Namecheap
  module Response
    ERRORS = {
      # Authentication
      1010101 => 'Parameter APIUser is missing',
      1030408 => 'Unsupported authentication type',
      1010104 => 'Parameter Command is missing',
      1010102 => 'Parameter APIKey is missing',
      1011102 => 'Parameter APIKey is missing',
      1010105 => 'Parameter ClientIP is missing',
      1011105 => 'Parameter ClientIP is missing',
      1050900 => 'Unknown error when validating APIuser',
      1011150 => 'Parameter RequestIP is invalid',
      1017150 => 'Parameter RequestIP is disabled or locked',
      1017105 => 'Parameter ClientIP is disabled or locked',
      1017101 => 'Parameter ApiUser is disabled or locked',
      1017410 => 'Too many declined payments',
      1017411 => 'Too many login attempts',
      1019103 => 'Parameter UserName is not available',
      1016103 => 'Parameter UserName is unauthorized',
      1017103 => 'Parameter UserName is disabled or locked',
      # namecheap.domains.getList
      5019169 => 'Unknown exceptions while retriving Domain list',
      # namecheap.domains.create
      2033409 => 'Possibly a logical error in authentication phase. The order chargeable for Username is not found',
      2033407 => 'Cannot enable Whoisguard when AddWhoisguard is set as NO',
      2033270 => 'Cannot enable Whoisguard when AddWhoisguard is set as NO',
      2015267 => 'EUAgreeDelete option should not be set as NO',
      2011170 => 'Validation error from PromotionCode',
      2015182 => 'The contact phone is invalid. The phone number format is +NNN.NNNNNNNNNN',
      2011280 => 'Validation error from TLD',
      2015167 => 'Validation error from Years',
      2030280 => 'TLD is not supported in API',
      2011168 => 'Nameservers are not valid',
      2011322 => 'Extended Attributes are not Valid',
      2010323 => 'Check required field for billing domain contacts',
      2528166 => 'Order creation failed',
      3019166 => 'Domain not available',
      4019166 => 'Domain not available',
      3031166 => 'Error while getting information from provider',
      3028166 => 'Error from Enom ( Errcount <> 0 )',
      3031900 => 'Unknown Response from provider',
      4023271 => 'Error while adding free positive ssl for the domain',
      3031166 => 'Error while getting Domin status from Enom',
      4023166 => 'Error while adding domain',
      5050900 => 'Unknown error while adding domain to your account',
      4026312 => 'Error in refunding funds',
      5026900 => 'Unknown exceptions error while refunding funds',
      # namecheap.domains.check
      3031510 => 'Error response from Enom when the error count != 0',
      3011511 => 'UnKnown response from Provider',
    }.freeze

    def self.processor_for(command)
      begin
        parse_command(command).inject(self) do
          |base, part| base.const_get part
        end
      rescue
        nil
      end
    end

    def self.parse_command(command)
      parts = command.split('.')

      parts.map do |part|
        part[0] = part[0].upcase

        part
      end
    end
  end
end

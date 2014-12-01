module Namecheap
  module Response
    module Domains
      class GetContacts < Processor
        attr_reader :contacts

        CONTACT_TYPES = [
          'Registrant',
          'Tech',
          'Admin',
          'AuxBilling'
        ].freeze

        def initialize(body)
          super

          @contacts = {}

          extract_contacts unless bad_request
        end

        private

        def extract_contacts
          list = response.xpath '//xmlns:DomainContactsResult'

          list.children.each do |li|
            if CONTACT_TYPES.include? li.name
              contacts[li.name] = Contact.new(li.name, li.children)
            end
          end
        end
      end
    end
  end
end

module Namecheap
  module Response
    class Contact
      ATTRIBUTE_MAP = {
        'OrganizationName' => :orginization,
        'JobTitle' => :job,
        'FirstName' => :first_name,
        'LastName' => :last_name,
        'Address1' => :address1,
        'Address2' => :address2,
        'City' => :city,
        'StateProvince' => :state,
        'StateProvinceChoice' => :state_choice,
        'PostalCode' => :postal_code,
        'Country' => :country,
        'Phone' => :phone,
        'Fax' => :fax,
        'EmailAddress' => :email,
        'PhoneExt' => :phone_extension }.freeze

      attr_reader *(ATTRIBUTE_MAP.values << :type)

      def initialize(type, nodes)
        @type = type

        process nodes
      end

      private

      def process(nodes)
        nodes.each do |node|
          attrs.include?(node.name) ? set(ATTRIBUTE_MAP[node.name], node.text) : next
        end
      end

      def attrs
        @attrs ||= ATTRIBUTE_MAP.keys
      end

      def set(ivar, value)
        instance_variable_set "@#{ivar}", value
      end
    end
  end
end

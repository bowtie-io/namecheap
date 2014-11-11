module Namecheap
  module Response
    module Domains
      class Check < Processor
        attr_reader :availability

        def initialize(body)
          super

          @bad_request ? mark_bad : set_availability
        end

        def available?(domain)
          @available = availability[domain]

          to_bool :@available
        end

        def successful?
          @successful
        end

        private

        def mark_bad
          @successful = false
          @availability = {}
        end

        def set_availability
          @availability = response.xpath('//xmlns:DomainCheckResult').inject({}) do |avb, node|
            avb[node['Domain']] = node['Available']

            avb
          end
        end
      end
    end
  end
end

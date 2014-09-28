module Namecheap
  module Response
    module Domains
      class Create < Processor
        attr_reader :domain, :order_id, :domain_id, :charged_amount, :transaction_id, :whoisguard_enabled, :non_realtime_domain

        def initialize(body)
          super

          @successful = process_purchase
        end

        def successful?
          @successful
        end

        def whoisguard_enabled?
          to_bool :@whoisguard_enabled
        end

        def non_realtime_domain?
          to_bool :@non_realtime_domain
        end

        private

        def process_purchase
          registration = response.xpath '//xmlns:DomainCreateResult'

          set_attributes(registration.first)

          registration.first['Registered'] == 'true'
        end

        def set_attributes(create_result)
          @domain = create_result['Domain']
          @charged_amount = create_result['ChargedAmount'].to_f
          @domain_id = create_result['DomainID']
          @order_id = create_result['OrderID']
          @transaction_id = create_result['TransactionID']
          @whoisguard_enabled = create_result['WhoisguardEnable']
          @non_realtime_domain = create_result['NonRealTimeDomain']
        end
      end
    end
  end
end

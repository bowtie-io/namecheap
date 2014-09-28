module Namecheap
  module Response
    class Processor
      attr_reader :response

      def initialize(body)
        @response = Nokogiri::XML(body)

        set_errors if has_errors?
      end

      def errors
        @errors ||= []
      end

      private

      def set_errors
        @errors = response.xpath('//xmlns:Errors').to_a
      end

      def has_errors?
        !response.xpath('//xmlns:Errors').children.empty?
      end

      def to_bool(ivar)
        instance_variable_get(ivar).match(/false/i).nil?
      end
    end
  end
end

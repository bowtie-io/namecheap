module Namecheap
  module Response
    module Domains
      class GetList < Processor
        attr_reader :page, :page_size, :total_length, :list

        def initialize(body)
          super

          process_list
          process_paging
        end

        private

        def process_list
          list = response.xpath '//xmlns:DomainGetListResult'

          @list = list.children.inject({}) do |domains, domain|
            next(domains) unless domain['Name']
            domains[domain['Name']] = populate_domain(domain)

            domains
          end
        end

        def populate_domain(node)
          domain_parts = {}
          node.attributes.keys.each { |attr| domain_parts[attr] = node[attr] }

          domain_parts
        end

        def process_paging
          @page = response.xpath('//xmlns:CurrentPage').children.first
          @page_size = response.xpath('//xmlns:PageSize').children.first
          @total_length = response.xpath('//xmlns:TotalItems').children.first

          normalize_paging
        end

        def normalize_paging
          @page = @page.to_s.to_i
          @page_size = @page_size.to_s.to_i
          @total_length = @total_length.to_s.to_i
        end
      end
    end
  end
end

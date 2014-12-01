require 'active_support/core_ext/string/inflections'

module Namecheap
  class Api
    SANDBOX = 'https://api.sandbox.namecheap.com/xml.response'
    PRODUCTION = 'https://api.namecheap.com/xml.response'
    ENVIRONMENT = defined?(Rails) && Rails.respond_to?(:env) ? Rails.env : (ENV["RACK_ENV"] || 'development')

    def get(command, options = {})
      response = request 'get', command, options

      process(command, response)
    end

    def post(command, options = {})
      response = request 'post', command, options

      process(command, response)
    end

    def put(command, options = {})
      response = request 'post', command, options

      process(command, response)
    end

    def delete(command, options = {})
      response = request 'post', command, options

      process(command, response)
    end

    def request(method, command, options = {})
      command = 'namecheap.' + command
      options = init_args.merge(options).merge({:command => command})
      options.keys.each do |key|
        options[key.to_s.camelize] = options.delete(key)
      end

      case method
      when 'get'
        #raise options.inspect
        HTTParty.get(endpoint, { :query => options})
      when 'post'
        HTTParty.post(endpoint, { :query => options})
      when 'put'
        HTTParty.put(endpoint, { :query => options})
      when 'delete'
        HTTParty.delete(endpoint, { :query => options})
      end
    end

    private
    def init_args
      %w(username key client_ip).each do |key|
        if Namecheap.config.key.nil?
          raise Namecheap::Config::RequiredOptionMissing,
            "Configuration parameter missing: #{key}, " +
            "please add it to the Namecheap.configure block"
        end
      end

      _options = {
        api_user:  Namecheap.config.username,
        user_name: Namecheap.config.username,
        api_key:   Namecheap.config.key,
        client_ip: Namecheap.config.client_ip
      }
    end

    def endpoint
      Namecheap.config.endpoint ||
       (ENVIRONMENT == 'production' ? PRODUCTION : SANDBOX)
    end

    def process(command, response)
      processor = response_processor command
      processor ? processor.new(response.body) : response
    end

    def response_processor(command)
      Response.processor_for command
    end
  end
end

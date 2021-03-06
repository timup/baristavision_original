module Clover
  class Base

    include HTTParty

    def initialize(access_token, merchant_id)
      @access_token = access_token
      @merchant_id = merchant_id
    end

    def merchant
      response = self.class.get("/v3/merchants/#{@merchant_id}", query: {:access_token => "#{@access_token}"})
    end

    def items
      response = query({
      :endpoint => "/v3/merchants/#{@merchant_id}/items",
      :method => :GET,
      :params => {
        :access_token => @access_token
        }
      })
    end

    def query opts
      method   = opts[:method].to_s.downcase
      response = self.class.send(method, opts[:endpoint], query: opts[:params])
      data     = response.parsed_response

      if response.success?
        if [ TrueClass, FalseClass, Fixnum ].include?(data.class)
          data
        else
          convert_to_mash(data)
        end
      else
        nil
      end
    end

    private

    def convert_to_mash data
      if data.is_a? Hash
        Hashie::Mash.new(data)
      elsif data.is_a Array
        data.map { |d| Hashie::Mash.new(d) }
      end
    end

  end
end

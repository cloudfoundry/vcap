require 'httpclient'
require 'base64'
require 'errors'

module VCAP
  module BlobStore
    class Client

      def initialize(options)
        @client = HTTPClient.new
        @endpoint = options["endpoint"]
        @headers = {}
        if options["user"] && options["password"]
          @headers["Authorization"] = "Basic " + Base64.encode64("#{options["user"]}:#{options["password"]}").strip
        end
      end

      def create(file)
        response = @client.post("#{@endpoint}/resources", {:content => file}, @headers)
        if response.status != 200
          raise BlobStoreError, "Could not create object, #{response.status}/#{response.content}"
        end
        response.content
      end

      def get(id, file = nil)
        bits = nil
        response = @client.get("#{@endpoint}/resources/#{id}", {}, @headers) do |block|
          if file
            file.write(block)
          else
            bits = block
          end
        end

        if response.status != 200
          raise BlobStoreError, "Could not fetch object, #{response.status}/#{response.content}"
        end
        bits
      end

      def delete(id)
        response = @client.delete("#{@endpoint}/resources/#{id}", @headers)
        if response.status != 204
          raise "Could not delete object, #{response.status}/#{response.content}"
        end
      end
    end
  end
end

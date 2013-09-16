require 'base64'
require 'openssl'
require 'typhoeus'

module Childsplay
  class Client
    attr_accessor :api_key, :api_secret, :headers, :format

    def initialize(api_key, api_secret, ssl = true, format = :json)
      @api_key = api_key
      @api_secret = api_secret
      @format = format
      @base_url = 'donate.childsplaycharity.org'
      @headers = { 'Host'         => @base_url,
                   'Date'         => cp_date_format,
                   'Content-MD5'  => '', 
                   'Content-Type' => '',
                   'User-Agent'   => 'CP/ruby' }
    end

    def get(endpoint, options = {})
      url = "https://#{@base_url}/api/#{endpoint}"
      update_headers(['', :api, endpoint].join('/'))

      request = Typhoeus::Request.new(url, headers: @headers)
      request.run
      return request.response
    end

    private

    def update_headers(uri)
      update_date_header
      update_auth_header(uri)
    end

    def update_auth_header(url)
      sig = ['GET', @headers['Content-MD5'], @headers['Content-Type'],
             @headers['Date'], url].join("\n")
      puts sig
      hashed_sig = OpenSSL::HMAC.digest('sha256', @api_secret, sig)
      encoded_sig = Base64.strict_encode64(hashed_sig)

      @headers['Authorization'] = "CP #{@api_key}:#{encoded_sig}"
    end

    def update_date_header
      @headers['Date'] = cp_date_format
    end

    def cp_date_format
      Time.now.gmtime.strftime("%a, %d %b %Y %H:%M:%S %Z"),
    end
  end
end

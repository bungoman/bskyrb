# frozen_string_literal: true

require_relative "bskyrb/version"
require 'json'
require 'net/http'
require 'date'
module ATProto
  class Session
    def initialize(username, password)
      @atp_host = "https://bsky.social"
      @atp_auth_token = ""
      @did = ""
      @username = username
  
      data = { "identifier" => username, "password" => password }.to_json
  
      uri = URI("#{@atp_host}/xrpc/com.atproto.server.createSession")
      response = Net::HTTP.post(uri, data, 'Content-Type' => 'application/json')
  
      parsed_response = JSON.parse(response.body)
  
      @atp_auth_token = parsed_response['accessJwt']
  
      if @atp_auth_token.nil?
        raise ValueError.new("No access token, is your password wrong?")
      end
  
      @did = parsed_response['did']
    end
    def getdid()
      puts @did
    end
  end
end 

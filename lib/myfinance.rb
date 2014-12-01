require "myfinance/version"
require 'httparty'

module Myfinance

  include HTTParty

  attr_accessor :token, :endpoint

  def self.setup(token,production=false)
    if production
      @endpoint = 'https://app.myfinance.com.br'
    else
      @endpoint = 'https://sandbox.myfinance.com.br'
    end
    base_uri @endpoint
    @token = token
  end

  def self.pessoa_id(cnpj)
    mid = nil
    all_people = lget '/people.json'
    puts all_people.inspect


    all_people.each do | people |
      cliente = people['person']
      if cliente['federation_subscription_number_only_numbers'] == cnpj  or cliente['federation_subscription_number'] == cnpj
        mid = cliente['id']
        break
      end
    end
    mid
  end

  def self.pessoa(cnpj)
    mid = pessoa_id(cnpj)
    response = lget "/people/#{mid}.json"
    response['person']
  end

  def self.cria_pessoa( pessoa )
    cnpj = pessoa['federation_subscription_number_only_numbers']
    id = pessoa_id(cnpj)
    people = { 'person' => pessoa }
    if id
      people['person']['id'] = id
    end
    response = lpost '/people.json', people
    response['person']
  end

  private

  def self.lget(url)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
    }
    get url, options
  end

  def self.lpost(url,data)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
        :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' }
    }
    response = post url, options
    response
  end

  def self.format_time(dt)
    dt.strftime('%FT%H:%MZ') rescue nil
  end

end


require 'httparty'
require 'httmultiparty'
require 'myfinance/version'
require 'myfinance/entidade'
require 'myfinance/pessoa'
require 'myfinance/conta_a_pagar'
require 'myfinance/conta_a_receber'
require 'myfinance/imposto'
require 'myfinance/categoria'
require 'myfinance/centro_receita_custo'
require 'myfinance/account'
require 'myfinance/conta_deposito'
require 'myfinance/webhook'
require 'myfinance/anexo'
require 'json'

module Myfinance

  # include HTTParty
  include HTTMultiParty

  attr_accessor :token, :endpoint, :account_id

  def self.setup(token, production=false, account_id=nil)
    if production
      @endpoint = 'https://app.myfinance.com.br'
    else
      @endpoint = 'https://sandbox.myfinance.com.br'
      # @endpoint = 'https://app.myfinance.com.br'
    end
    base_uri @endpoint
    @token = token
    # testo com uma chamada simples
    response = accounts
    # Resposta deve ser um array de hashes
    unless response.code == 200
      raise "Erro ao inicializar a API do MyFinance: #{response.code} : #{response.parsed_response}"
    end
    @account_id = get_account_id(account_id, response)
  end

  def account_id
    @account_id
  end

  private

  def self.lget(url)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
        :headers => { 'Content-Type' => 'application/json' }
    }
    add_account_id options
    get url, options
  end

  def self.lpost(url,post_data)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
        :body => post_data.to_json,
        :headers => { 'Content-Type' => 'application/json' }
    }
    add_account_id options
    response = post url, options
    response
  end

  def self.lput(url,post_data)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
        :body => post_data.to_json,
        :headers => { 'Content-Type' => 'application/json' }
    }
    add_account_id options
    response = put url, options
    response
  end

  def self.ldelete(url)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
        :headers => { 'Content-Type' => 'application/json' }
    }
    add_account_id options
    response = delete url, options
    response
  end

  def self.format_time(dt)
    dt.strftime('%FT%H:%MZ') rescue nil
  end

  def self.add_account_id(options)
    options[:headers]['ACCOUNT_ID'] = @account_id.to_s if @account_id
  end

  def self.get_account_id(account_id, accounts_response)
    return account_id unless (account_id.nil? or account_id == "")
    accounts_response.first["account"]["id"]
  end
end


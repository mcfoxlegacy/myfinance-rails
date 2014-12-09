require 'httparty'
require 'myfinance/version'
require 'myfinance/entidade'
require 'myfinance/pessoa'
require 'myfinance/conta_a_receber'
require 'myfinance/imposto'
require 'myfinance/categoria'
require 'myfinance/centro_receita_custo'
require 'json'

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
    # testo com uma chamada simples
    response = lget('/entities.json')
    # Resposta deve ser um array de hashes
    unless response.code == 200
      raise "Erro ao inicializar a API do MyFinance: #{response.code} : #{response.parsed_response}"
    end
  end

  private

  def self.lget(url)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
    }
    get url, options
  end

  def self.lpost(url,post_data)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
        :body => post_data.to_json,
        :headers => { 'Content-Type' => 'application/json' }
    }
    response = post url, options
    response
  end

  def self.lput(url,post_data)
    options = {
        :basic_auth => {:username => @token, :password => 'x'},
        :body => post_data.to_json,
        :headers => { 'Content-Type' => 'application/json' }
    }
    response = put url, options
    response
  end

  def self.format_time(dt)
    dt.strftime('%FT%H:%MZ') rescue nil
  end

end


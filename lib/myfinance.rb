require 'httparty'
require 'myfinance/version'
require 'myfinance/entidade'
require 'myfinance/pessoa'
require 'myfinance/conta_a_receber'
require 'myfinance/imposto'
require 'myfinance/categoria'
require 'myfinance/centro_receita_custo'

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


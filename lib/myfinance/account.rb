module Myfinance

  def self.account_id(account_name)
    mid = nil
    available_accounts = accounts
    available_accounts.each do | item |
      item = item['account']
      if item['name'] == account_name
        mid = item['id']
        break
      end
    end
    mid
  rescue => e
    raise "Não foi retornado um array de contas como esperado: #{available_accounts.inspect}. #{e.message}"
  end

  def self.accounts
    lget '/accounts.json'
  end

end


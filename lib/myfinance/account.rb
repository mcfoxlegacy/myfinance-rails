module Myfinance


  def self.account_id(nome)
    mid = nil
    accounts.each do | item |
      item = item['account']
      if item['name'] == nome
        mid = item['id']
        break
      end
    end
    mid
  end

  def self.accounts
    lget '/accounts.json'
  end

end


module Myfinance

  def self.accounts
    lget '/accounts.json'
  end
end


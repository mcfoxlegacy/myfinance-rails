module Myfinance

  def self.contas_deposito(entity_id)
    lget "/entities/#{entity_id}/deposit_accounts.json"
  end
end


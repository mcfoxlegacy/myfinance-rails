module Myfinance

  def self.contas_deposito(entity_id)
    lget "/entities/#{entity_id}/deposit_accounts.json"
  end

  def self.conta_deposito_id(entity_id, nome)
    mid = nil
    contas_deposito(entity_id).each do | item |
      conta = item["deposit_account"]
      if conta["name"].strip == nome.strip
        mid = conta["id"]
        break
      end
    end
    mid
  end
end

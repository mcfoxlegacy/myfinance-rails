module Myfinance

  def self.contas_deposito(entity_id)
    lget "/entities/#{entity_id}/deposit_accounts.json"
  end

  def self.conta_deposito_id(entity_id, nome)
    contas_deposito(entity_id).each do | item |
      conta = item["deposit_account"]
      if conta["name"].strip.downcase == nome.strip.downcase
        return conta["id"]
        break
      end
    end
    nil
  end

  def self.contas_deposito_like(entity_id, like_str)
    contas = []
    contas_deposito(entity_id).each do | item |
      conta = item["deposit_account"]
      if conta["name"].strip.downcase.include?(like_str.downcase)
        contas << conta
      end
    end
    contas
  end

end

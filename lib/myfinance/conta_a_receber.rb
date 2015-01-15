module Myfinance

  def self.cria_conta_a_receber_entidade(nome_da_entidade,faturamento)
    entity_id = entidade_id(nome_da_entidade)
    cria_conta_a_receber(entity_id,faturamento)
  end

  def self.cria_conta_a_receber(entity_id,faturamento)
    receivable_account = {
        'receivable_account' => faturamento
    }
    response = lpost "/entities/#{entity_id}/receivable_accounts.json", receivable_account
    response
  end

  def self.conta_a_receber(id, entity_id)
    lget "/entities/#{entity_id}/receivable_accounts/#{id}.json"
  end

  def self.apaga_conta_a_receber(id, entity_id)
    ldelete "/entities/#{entity_id}/receivable_accounts/#{id}.json"
  end

  def self.altera_conta_a_receber(id, entity_id, faturamento)
    lput "/entities/#{entity_id}/receivable_accounts/#{id}.json", faturamento
  end
end

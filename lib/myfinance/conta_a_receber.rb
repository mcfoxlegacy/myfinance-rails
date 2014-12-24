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


end


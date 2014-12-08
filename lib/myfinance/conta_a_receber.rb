module Myfinance

  def self.cria_conta_a_receber(nome_da_entidade,faturamento)
    entity_id = entidade_id(nome_da_entidade)
    receivable_account = {
        'receivable_account' => faturamento
    }
    response = lpost "/entities/#{entity_id}/receivable_accounts.json", receivable_account
    response['receivable_account']
  end



end


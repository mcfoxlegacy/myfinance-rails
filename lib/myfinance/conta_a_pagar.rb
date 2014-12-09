module Myfinance

  def self.cria_conta_a_pagar(nome_da_entidade,pagamento)
    entity_id = entidade_id(nome_da_entidade)
    payable_account = {
        'payable_account' => pagamento
    }
    response = lpost "/entities/#{entity_id}/payable_accounts.json", payable_account
    response['payable_account']
  end

end


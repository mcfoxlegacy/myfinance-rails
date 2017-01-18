module Myfinance

  def self.cria_conta_a_pagar_entidade(nome_da_entidade,faturamento)
    entity_id = entidade_id(nome_da_entidade)
    cria_conta_a_pagar(entity_id,faturamento)
  end

  def self.busca_conta_a_pagar(entity_id, nfe_id, search_field = 'description')
    raise 'Enitidade não informada!' unless entity_id
    lget "/entities/#{entity_id}/payable_accounts.json?search[#{search_field}_like]=#{nfe_id}"
  end

  def self.cria_conta_a_pagar(entity_id,pagamento)
    raise 'Enitidade não informada!' unless entity_id
    response = lpost "/entities/#{entity_id}/payable_accounts.json", parametro_conta_a_pagar(pagamento)
    response
  end

  def self.apaga_conta_a_pagar(id, entity_id)
    ldelete "/entities/#{entity_id}/payable_accounts/#{id}.json"
  end

  def self.conta_a_pagar(id, entity_id)
    lget "/entities/#{entity_id}/payable_accounts/#{id}.json"
  end

  def self.parametro_conta_a_pagar(pagamento)
    {
        'payable_account' => pagamento
    }
  end

  private_class_method :parametro_conta_a_pagar

end


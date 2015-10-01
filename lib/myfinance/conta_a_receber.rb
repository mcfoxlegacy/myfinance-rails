module Myfinance
  def self.cria_conta_a_receber_entidade(nome_da_entidade,faturamento)
    entity_id = entidade_id(nome_da_entidade)
    cria_conta_a_receber(entity_id,faturamento)
  end

  def self.cria_conta_a_receber(entity_id, faturamento)
    lpost "/entities/#{entity_id}/receivable_accounts.json",
          parametro_conta_a_receber(faturamento)
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

  def self.recebe_conta_a_receber(id, entity_id, faturamento)
    lput "/entities/#{entity_id}/receivable_accounts/#{id}/receive.json",
         parametro_conta_a_receber(faturamento)
  end

  def self.desfaz_recebimento_de_conta_a_receber(id, entity_id)
    lput "/entities/#{entity_id}/receivable_accounts/#{id}/undo_receivement.json", {}
  end

  def self.parametro_conta_a_receber(faturamento)
    receivable_account = {
      'receivable_account' => faturamento
    }
  end

  private_class_method :parametro_conta_a_receber
end

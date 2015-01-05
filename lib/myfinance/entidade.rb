module Myfinance

  def self.entidade_id(nome)
    mid = nil
    entidades.each do | ent |
      cliente = ent['entity']
      if cliente['name'] == nome or cliente['federation_subscription_number'] == nome
        mid = cliente['id']
        break
      end
    end
    mid
  end

  def self.entidade(nome)
    mid = entidade_id(nome)
    response = lget "/entities/#{mid}.json"
    response['entity']
  end

  def self.entidades
    lget '/entities.json'
  end
end


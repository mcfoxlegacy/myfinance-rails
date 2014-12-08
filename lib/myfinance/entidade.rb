module Myfinance

  def self.entidade_id(nome)
    mid = nil
    response = lget '/entities.json'
    response.each do | ent |
      cliente = ent['entity']
      if cliente['name'] == nome
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


end


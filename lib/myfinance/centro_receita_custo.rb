module Myfinance

  def self.centro_de_receita_id(nome)
    centro_id(nome,false)
  end

  def self.centro_de_custo_id(nome)
    centro_id(nome,true)
  end

  def self.centro_id(nome, custo = nil)
    mid = nil
    response = lget '/classification_centers.json'
    response.each do | item |
      cc = item['classification_center']
      if cc['name'] == nome
        if custo.nil? or cc['cost_center'] == custo
          mid = cc['id']
        end
        break
      end
    end
    mid
  end

end


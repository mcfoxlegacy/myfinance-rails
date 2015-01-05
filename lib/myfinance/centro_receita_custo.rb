module Myfinance

  def self.centro_de_receita_id(nome)
    centro_id(nome,false)
  end

  def self.centro_de_custo_id(nome)
    centro_id(nome,true)
  end

  def self.centro_id(nome, custo = nil)
    mid = nil
    centros(custo).each do | item |
      cc = item['classification_center']
      if cc['name'] == nome
        mid = cc['id']
        break
      end
    end
    mid
  end

  def self.centros(custo = nil)
    items = Array.new
    classification_centers.each do | item |
      cc = item['classification_center']
      if custo.nil?
        items.push(item)
      else
        if custo
          if cc['cost_center']
            items.push(item)
          end
        else
          if cc['revenue_center']
            items.push(item)
          end
        end
      end
    end
    items
  end

  def self.classification_centers
    lget '/classification_centers.json'
  end
end


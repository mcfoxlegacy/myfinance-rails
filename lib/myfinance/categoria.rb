module Myfinance

  def self.categoria_id(nome)
    mid = nil
    categorias.each do | item |
      category = item['category']
      if category['full_name'] == nome
        mid = category['id']
        break
      end
    end
    mid
  end

  def self.categorias
    lget '/categories.json'
  end
end


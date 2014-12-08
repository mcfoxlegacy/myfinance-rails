module Myfinance

  def self.categoria_id(nome)
    mid = nil
    response = lget '/categories.json'
    response.each do | item |
      category = item['category']
      if category['full_name'] == nome
        mid = category['id']
        break
      end
    end
    mid
  end

end


module Myfinance

  def self.imposto_id(nome)
    mid = nil
    response = lget '/taxes.json'
    response.each do | item |
      imposto = item['tax']
      if imposto['name'] == nome
        mid = imposto['id']
        break
      end
    end
    mid
  end

end


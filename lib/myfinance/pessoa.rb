module Myfinance

  def self.pessoa_id(cnpj)
    mid = nil
    response = lget '/people.json'
    response.each do | people |
      cliente = people['person']
      if cliente['federation_subscription_number_only_numbers'] == cnpj  or cliente['federation_subscription_number'] == cnpj
        mid = cliente['id']
        break
      end
    end
    mid
  end

  def self.pessoa(cnpj)
    mid = pessoa_id(cnpj)
    response = lget "/people/#{mid}.json"
    response['parsed_response']['person']
  end

  def self.cria_pessoa( pessoa )
    # Vou rezar para que de certo
    people = { 'person' => pessoa }
    lpost '/people.json', people
  end

end


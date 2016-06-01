module Myfinance

  def self.pessoa_id(cnpj_ou_nome)
    person = pessoa(cnpj_ou_nome)
    person.nil? ? nil : person["id"]
  end

  def self.pessoa(cnpj_ou_nome)
    person = pesquisa_pessoa("federation_subscription_number", cnpj_ou_nome)
    person ||= pesquisa_pessoa("name", cnpj_ou_nome)
    person
  end

  def self.pesquisa_pessoa(campo, valor)
    people =  Myfinance.lget URI.encode("/people.json?search[#{campo}]=#{valor}")
    people.empty? ? nil : people[0]["person"]
  end

  def self.cria_pessoa( pessoa )
    # Vou rezar para que de certo
    @everyone = nil
    people = { 'person' => pessoa }
    lpost '/people.json', people
  end

  def self.atualiza_pessoa( people_id, pessoa )
    # Vou rezar para que de certo
    # people = { 'person' => pessoa }
    @everyone = nil
    lput "/people/#{people_id}.json", pessoa
  end
end


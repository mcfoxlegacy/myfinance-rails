module Myfinance

  def self.pessoa_id(cnpj)
    @everyone ||= all_people
    mid = nil
    @everyone.each do | pessoa |
      if pessoa['federation_subscription_number_only_numbers'] == cnpj  or pessoa['federation_subscription_number'] == cnpj
        mid = pessoa['id']
        break
      end
    end
    mid
  end

  def self.all_people
    everyone = []
    response = lget "/people.json"
    total_pages = get_last_page(response)
    for page in 1..total_pages
      response = lget "/people.json?page=#{page}"
      response.each do | people |
        everyone << people['person']
      end
    end
    everyone
  end

  def self.pessoa(cnpj)
    mid = pessoa_id(cnpj)
    response = lget "/people/#{mid}.json"
    response['person'] if response
  end

  def self.cria_pessoa( pessoa )
    # Vou rezar para que de certo
    people = { 'person' => pessoa }
    lpost '/people.json', people
  end

  def self.atualiza_pessoa( people_id, pessoa )
    # Vou rezar para que de certo
    # people = { 'person' => pessoa }
    lput "/people/#{people_id}.json", pessoa
  end


  def self.get_last_page(response)
    total_pages = 1
    links = (response.header['link'].split(',') rescue [])
    link = links.find{ |l| l.include?('last') }
    if link
      total_pages = (link.split(";")[0].split('?')[1].gsub('page=','').to_i rescue 1)
    end
    total_pages
  end


end


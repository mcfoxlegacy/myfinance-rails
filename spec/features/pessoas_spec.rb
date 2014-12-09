describe 'Manipulando Pessoas', type: :feature do

  require 'myfinance'

  it 'deve poder criar um cliente e achar o seu id pelo cnpj' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    cliente = {
        'address'=>'Rua Tal, número 0',
        'city'=>'Rio de Janeiro',
        'complement'=>'sala 1234',
        'country'=>'Brasil',
        'customer'=>true,
        'email'=>'cliente@fulano.com',
        'federation_subscription_number'=>'27.206.831/0001-70',
        'name'=>'Fulano de Tal',
        'note'=>'Notas sobre este cliente...',
        'person_type'=>'JuridicalPerson',
        'phone'=>'(21) 5555-1234',
        'site'=>'http=>//www.fulano.com',
        'state'=>'RJ',
        'supplier'=>false,
        'zip_code'=>'22290-080'
    }
    novo_cliente = Myfinance.cria_pessoa(cliente)
    expect(novo_cliente['name']).to_not be_nil

    id = Myfinance.pessoa_id(cliente['federation_subscription_number'])
    expect(id).to_not be_nil



  end


end
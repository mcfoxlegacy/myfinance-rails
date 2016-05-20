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
    expect(novo_cliente['federation_subscription_number']).to_not be_nil

    id = Myfinance.pessoa_id(cliente['federation_subscription_number'])
    expect(id).to_not be_nil

    cliente['name'] = 'Ciclano'
    response = Myfinance.atualiza_pessoa(id, cliente)
    expect(response.code).to equal(200)

    mesmo_cliente = Myfinance.pessoa(cliente['federation_subscription_number'])
    expect(mesmo_cliente).to_not be_nil
    expect(mesmo_cliente['name']).to eq('Ciclano')

  end

  it 'Se procurar por um cnpj não cadastrado, deve voltar nulo' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    id = Myfinance.pessoa_id('67977504999999')
    expect(id).to be_nil
  end

  it 'Se procurar por um cnpj cadastrado, deve voltar id' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    id = Myfinance.pessoa_id('27206831000170')
    expect(id).to_not be_nil
  end

  it 'Se procurar por nome cadastrado, deve voltar id' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    id = Myfinance.pessoa_id('Ciclano')
    expect(id).to_not be_nil
  end

  it 'Se procurar por nome cadastrado, mas em case diferente, deve voltar id' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    id = Myfinance.pessoa_id('CiClAnO')
    expect(id).to_not be_nil
  end

  it 'Se procurar por nome não cadastrado, deve voltar id nulo' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    id = Myfinance.pessoa_id('Ciclano Ciclano')
    expect(id).to be_nil
  end

  it 'Se procurar por um cnpj cadastrado de outra conta, não deve voltar id' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277', false, 1)
    id = Myfinance.pessoa_id('27206831000170')
    expect(id).to be_nil
  end
end
describe 'Manipulando Entidades', type: :feature do

  require 'myfinance'

  it 'deve poder pegar o id de uma entidade pelo seu nome' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    nome = 'Minhas Finanças'
    id = Myfinance.entidade_id(nome)
    expect(id).to_not be_nil
  end

  it 'deve poder ler os dados uma entidade pelo seu nome' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    nome = 'Minhas Finanças'
    entidade = Myfinance.entidade(nome)
    expect(entidade['created_at']).to_not be_nil
    expect(entidade['deleted_at']).to be_nil
  end

end
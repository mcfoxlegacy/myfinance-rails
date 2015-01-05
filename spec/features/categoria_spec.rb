describe 'Manipulando Pessoas', type: :feature do

  require 'myfinance'

  it 'deve pegar o id de uma categoria  e de centro de receita pelo nome' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    categoria_id = Myfinance.categoria_id('Alimentação / Restaurantes')
    centro_de_receita_id = Myfinance.centro_de_receita_id('Projetos')
    expect(categoria_id).to_not be_nil
    expect(centro_de_receita_id).to_not be_nil
  end

  it 'Não deve pegar o id de uma categoria de custo para receita' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    centro_de_receita_id = Myfinance.centro_de_custo_id('Projetos')
    expect(centro_de_receita_id).to be_nil
  end

  it '#categorias' do
    double categorias_double = double('categorias_double')
    expect(Myfinance).to receive(:lget).once.with('/categories.json').and_return categorias_double
    expect(Myfinance.categorias).to eql(categorias_double)
  end
end
describe 'Manipulando Contas a Receber', type: :feature do

  require 'myfinance'

  it 'deve poder criar uma conta a receber para uma entidade e um cliente' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')

    cliente_id = Myfinance.pessoa_id('27.206.831/0001-70')
    categoria_id = Myfinance.categoria_id('Alimentação / Restaurantes')
    centro_de_receita_id = Myfinance.centro_de_receita_id('Projetos')

    faturamento = {
        'due_date' => (Date.today + 30),
        'occurred_at' => nil,
        'amount' => '100.0',
        'nominal_amount' => '100.0',
        'ticket_amount' => nil,
        'interest_amount' => 2,
        'discount_amount' => 5.0,
        'total_amount' => nil,
        'description' => 'Descrição do Faturamento',
        'document' => 'Contrato XPTO 30',
        'document_emission_date' => Date.today,
        'observation' => 'Observação do Faturamento',
        'income_tax_relevant' => true,
        'category_id' => categoria_id,
        'classification_center_id' => centro_de_receita_id,
        'person_id' => cliente_id,
        'expected_deposit_account_id' => nil,
        'create_as_recurrent' => nil,
        'remind' => true,
        'financial_account_taxes_attributes' => [
          {
            'tax_id' => Myfinance.imposto_id('ISS'),
            'amount' => '20.0'
          },
          {
            'tax_id' => Myfinance.imposto_id('PIS'),
            'amount' => '1.5'
          },
          {
            'tax_id' => Myfinance.imposto_id('COFINS'),
            'amount' => '2.0'
          },

        ]
      }
    conta_a_receber = Myfinance.cria_conta_a_receber('Minhas Finanças',faturamento)
    expect(conta_a_receber['id']).to_not be_nil

  end


end
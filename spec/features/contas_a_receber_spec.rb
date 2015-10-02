describe 'Manipulando Contas a Receber', type: :feature do
  require 'myfinance'

  it 'Se a cav não der acesso, ja devemos dar erro na chamado do setup' do
    expect { Myfinance.setup('nowaythiskeucanwork') }.to raise_error(RuntimeError)
  end

  it 'Se a cav não der acesso, ja devemos dar erro na chamado do setup' do
    expect { Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277') }.to_not raise_error
  end

  it 'deve poder criar uma conta a receber para uma entidade e um cliente' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')

    # entidade_id = Myfinance.entidade_id('06604529878')
    entidade_id = Myfinance.entidade_id('11.023.029/0001-05')
    cliente_id = Myfinance.pessoa_id('27.206.831/0001-70')
    categoria_id = Myfinance.categoria_id('Alimentação / Restaurantes')
    centro_de_receita_id = Myfinance.centro_de_receita_id('Projetos')

    faturamento = {
        'entity_id' => entidade_id,
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
    conta_a_receber = Myfinance.cria_conta_a_receber_entidade('Minhas Finanças', faturamento)
    expect(conta_a_receber['receivable_account']).to_not be_nil

    conta_a_receber = Myfinance.cria_conta_a_receber(entidade_id, faturamento)
    expect(conta_a_receber['receivable_account']).to_not be_nil
  end

  it '.conta_a_receber' do
    conta_a_receber_double = double('conta_a_receber')
    expect(Myfinance).to receive(:lget).once.with("/entities/2/receivable_accounts/1.json").and_return conta_a_receber_double
    expect(Myfinance.conta_a_receber(1,2)).to eql(conta_a_receber_double)
  end

  it ".apaga_conta_a_receber" do
    conta_a_receber_double = double('conta_a_receber')
    expect(Myfinance).to receive(:ldelete).once.with("/entities/2/receivable_accounts/1.json").and_return conta_a_receber_double
    expect(Myfinance.apaga_conta_a_receber(1, 2)).to eql(conta_a_receber_double)
  end

  it ".altera_conta_a_receber" do
    conta_a_receber_parameters_double = double('conta_a_receber_parameters')
    conta_a_receber_double = double('conta_a_receber')
    expect(Myfinance).to receive(:lput).once.with("/entities/2/receivable_accounts/1.json", conta_a_receber_parameters_double).and_return conta_a_receber_double
    expect(Myfinance.altera_conta_a_receber(1, 2, conta_a_receber_parameters_double)).to eql(conta_a_receber_double)
  end

  it ".recebe_conta_a_receber" do
    conta_a_receber_parameters_double = double('conta_a_receber_parameters')
    conta_a_receber_double = double('conta_a_receber')
    expect(Myfinance).to receive(:lput).once.with("/entities/2/receivable_accounts/1/receive.json", 'receivable_account' => conta_a_receber_parameters_double).and_return conta_a_receber_double
    expect(Myfinance.recebe_conta_a_receber(1, 2, conta_a_receber_parameters_double)).to eql(conta_a_receber_double)
  end

  it ".desfaz_recebimento_de_conta_a_receber" do
    conta_a_receber_double = double('conta_a_receber')
    expect(Myfinance).to receive(:lput).once.with("/entities/2/receivable_accounts/1/undo_receivement.json", {}).and_return conta_a_receber_double
    expect(Myfinance.desfaz_recebimento_de_conta_a_receber(1, 2)).to eql(conta_a_receber_double)
  end
end

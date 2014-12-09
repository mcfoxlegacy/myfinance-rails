# Myfinance::Rails

API integration with MyFinance (www.myfinance.com.br)

# API Documentation

https://app.myfinance.com.br/docs/api 

## Installation

Add this line to your application's Gemfile:

    gem 'myfinance-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install myfinance-rails

## Usage

    Myfinance.setup(<you_api_key>) # Informe sua API Key aqui

    cliente_id = Myfinance.pessoa_id('...')   # Informe o CNPJ aqui
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




## Contributing

1. Fork it ( https://github.com/[my-github-username]/myfinance-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

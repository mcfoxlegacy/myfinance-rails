describe 'Manipulando Contas de Depósito', type: :feature do

  require 'myfinance'

  it '#contas_deposito' do
    double contas_deposito_double = double("contas_deposito")
    expect(Myfinance).to receive(:lget).once.with("/entities/1/deposit_accounts.json").and_return contas_deposito_double
    expect(Myfinance.contas_deposito(1)).to eql(contas_deposito_double)
  end
end
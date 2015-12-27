describe 'Manipulando Contas de Depósito', type: :feature do

  require 'myfinance'

  it '#contas_deposito' do
    double contas_deposito_double = double("contas_deposito")
    expect(Myfinance).to receive(:lget).once.with("/entities/1/deposit_accounts.json").and_return contas_deposito_double
    expect(Myfinance.contas_deposito(1)).to eql(contas_deposito_double)
  end

  describe '#conta_deposito_id' do
    let!(:deposit_accounts_double) { [{"deposit_account"=>{"id"=>14330, "name"=>"Bradesco"}}, {"deposit_account"=>{"id"=>14331, "name"=>"Itaú"}}] }
    before do
      allow(Myfinance).to receive(:contas_deposito).with(1).and_return(deposit_accounts_double)
    end

    it "returns nil if no deposit account found" do
      expect(Myfinance.conta_deposito_id(1, "Citi")).to be nil
    end
    it "returns informed deposit account" do
      expect(Myfinance.conta_deposito_id(1, "Itaú")).to eql 14331
    end
  end
end
describe 'Manipulando Contas a Receber', type: :feature do

  require 'myfinance'

  it 'devo poder ler o id de um impostos' do
    Myfinance.setup('2acecbb483842ebbfb2c638070bf019b70e757190166d277')
    icms_id = Myfinance.imposto_id('ICMS')
    expect(icms_id).to_not be_nil
    ipi_id = Myfinance.imposto_id('IPI')
    expect(ipi_id).to_not be_nil
    iss_id = Myfinance.imposto_id('ISS')
    expect(iss_id).to_not be_nil
  end


end
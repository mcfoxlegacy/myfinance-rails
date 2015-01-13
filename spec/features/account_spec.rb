describe 'Account', type: :feature do

  require 'myfinance'

  it '#accounts' do
    double accounts_double = double('account')
    expect(Myfinance).to receive(:lget).once.with('/accounts.json').and_return accounts_double
    expect(Myfinance.accounts).to eql(accounts_double)
  end

  describe "specific account" do
    let(:response_double) { double("response", code: 200) }
    describe "informed" do
      before do
        expect(Myfinance).to receive(:accounts).and_return response_double
        Myfinance.setup "123456", false, 25
      end
      it "get" do
        expect(Myfinance).to receive(:get).with("/entities.json", {:basic_auth=>{:username=>"123456", :password=>"x"}, :headers=>{"Content-Type"=>"application/json", "ACCOUNT_ID"=>"25"}})
        Myfinance.entidades
      end
      it "post" do
        expect(Myfinance).to receive(:post).with("/people.json", {:basic_auth=>{:username=>"123456", :password=>"x"}, :body=>"{\"person\":{}}", :headers=>{"Content-Type"=>"application/json", "ACCOUNT_ID"=>"25"}})
        Myfinance.cria_pessoa({})
      end
      it "put" do
        expect(Myfinance).to receive(:put).with("/people/30.json", {:basic_auth=>{:username=>"123456", :password=>"x"}, :body=>"{}", :headers=>{"Content-Type"=>"application/json", "ACCOUNT_ID"=>"25"}})
        Myfinance.atualiza_pessoa(30, {})
      end
    end
    describe "not informed" do
      before do
        expect(Myfinance).to receive(:accounts).and_return response_double
        Myfinance.setup "123456", false
      end
      it "get" do
        expect(Myfinance).to receive(:get).with("/entities.json", {:basic_auth=>{:username=>"123456", :password=>"x"}, :headers=>{"Content-Type"=>"application/json"}})
        Myfinance.entidades
      end
      it "post" do
        expect(Myfinance).to receive(:post).with("/people.json", {:basic_auth=>{:username=>"123456", :password=>"x"}, :body=>"{\"person\":{}}", :headers=>{"Content-Type"=>"application/json"}})
        Myfinance.cria_pessoa({})
      end
      it "put" do
        expect(Myfinance).to receive(:put).with("/people/30.json", {:basic_auth=>{:username=>"123456", :password=>"x"}, :body=>"{}", :headers=>{"Content-Type"=>"application/json"}})
        Myfinance.atualiza_pessoa(30, {})
      end
    end
  end
end
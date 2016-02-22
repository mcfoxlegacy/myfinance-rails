describe 'Manipulando Webhooks', type: :feature do

  require 'myfinance'

  it "#cria_webhook" do
    webhook_double = double("webhook")
    new_webhook = double("new_webhook")
    expect(Myfinance).to receive(:lpost).with("/webhooks.json", webhook_double).and_return new_webhook
    expect(Myfinance.cria_webhook(webhook_double)).to eql new_webhook
  end

  it "#webhooks" do
    webhooks_double = double("webhooks")
    expect(Myfinance).to receive(:lget).with("/webhooks.json").and_return webhooks_double
    expect(Myfinance.webhooks).to eql webhooks_double
  end
end
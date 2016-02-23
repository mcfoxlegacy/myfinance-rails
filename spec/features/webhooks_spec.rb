require 'myfinance'

describe 'Manipulando Webhooks', type: :feature do
  it "#cria_webhook" do
    webhook_double = double("webhook")
    new_webhook = double("new_webhook")
    expect(Myfinance).to receive(:lpost).with("/integrations/webhooks.json", webhook_double).and_return new_webhook
    expect(Myfinance.cria_webhook(webhook_double)).to eql new_webhook
  end

  it "#webhooks" do
    webhooks_double = double("webhooks")
    expect(Myfinance).to receive(:lget).with("/integrations/webhooks.json").and_return webhooks_double
    expect(Myfinance.webhooks).to eql webhooks_double
  end

  it "#apaga_webhook" do
    webhook_double = double('webhook')
    expect(Myfinance).to receive(:ldelete).once.with("/integrations/webhooks/1.json").and_return webhook_double
    expect(Myfinance.apaga_webhook(1)).to eql webhook_double
  end
end

module Myfinance

  def self.cria_webhook(webhook)
    lpost "/webhooks.json", webhook
  end

  def self.webhooks
    lget "/webhooks.json"
  end
end


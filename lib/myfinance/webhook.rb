module Myfinance
  def self.cria_webhook(webhook)
    lpost "/integrations/webhooks.json", webhook
  end

  def self.webhooks
    lget "/integrations/webhooks.json"
  end

  def self.apaga_webhook(id)
    ldelete "/integrations/webhooks/#{id}.json"
  end
end

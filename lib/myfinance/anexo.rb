module Myfinance

  require 'tempfile'

  def self.anexa_arquivo(entity_id, receivable_id, nome_do_arquivo, conteudo_do_arquivo)
    attached_file = Tempfile.new(nome_do_arquivo)
    attached_file << conteudo_do_arquivo
    attached_file.rewind
    post_data = { attachment: {
        attachment: attached_file,
        title: nome_do_arquivo,
        associated_financial_transaction_ids: [receivable_id]
      }
    }
    response = lpost( "/entities/#{entity_id}/attachments",post_data)
    attached_file.close
    attached_file.unlink
    response
  end

end


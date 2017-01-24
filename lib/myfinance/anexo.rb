module Myfinance

  require 'tempfile'

  def self.cria_e_anexa_arquivo(entity_id, receivable_id, nome_do_arquivo, conteudo_do_arquivo)
    file = nome_do_arquivo.split('.')
    attached_file = Tempfile.new([file[0], ".#{file[1]}"])
    attached_file << conteudo_do_arquivo
    attached_file.rewind
    response = anexa_arquivo(entity_id, receivable_id, nome_do_arquivo, attached_file)
    attached_file.close
    attached_file.unlink
    response
  end


  def self.anexa_arquivo(entity_id, receivable_id, titulo, arquivo)
    post_data = { attachment: {
        attachment: arquivo,
        title: titulo,
        associated_financial_account_ids: [receivable_id]
      }
    }
    response = multi_party_post( "/entities/#{entity_id}/attachments",post_data)
    response
  end

end


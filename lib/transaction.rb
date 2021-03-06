require 'time'

class Transaction

  attr_reader :id,
            :invoice_id,
            :credit_card_number,
            :credit_card_expiration_date,
            :result,
            :created_at,
            :updated_at

  def initialize(trx_data, parent = nil)
    @parent = parent
    @id = trx_data[:id].to_i
    @invoice_id = trx_data[:invoice_id].to_i
    @credit_card_number = trx_data[:credit_card_number].to_i
    @credit_card_expiration_date = trx_data[:credit_card_expiration_date]
    @result = trx_data[:result]
    @created_at = Time.parse(trx_data[:created_at])
    @updated_at = Time.parse(trx_data[:updated_at])
  end

  def invoice
    sales_engine = @parent.parent
    sales_engine.invoices.find_by_id(invoice_id)
  end
end

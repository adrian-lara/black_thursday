require_relative 'transaction'
require 'csv'

class TransactionRepository

  attr_reader :all, :parent

  def initialize(file_path, parent = nil)
    @all = from_csv(file_path)
    @parent = parent
  end

  def from_csv(file_path)
    trxr_array = []
    options = {headers: true, header_converters: :symbol}
    CSV.foreach(file_path, options ) do |row|
      trxr_array << Transaction.new(row, self)
    end
    trxr_array
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    @all.find do |transaction_item|
      transaction_item.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction_item|
      transaction_item.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(number)
    @all.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction_item|
      transaction_item.result == result
    end
  end

end

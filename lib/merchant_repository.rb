require_relative 'merchant'
require 'csv'

class MerchantRepository

  attr_reader :merchants,
              :parent

  def initialize(file_path, parent = nil)
    @merchants = []
    load_csv(file_path)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def load_csv(file_path)
    options = {headers: true, header_converters: :symbol, converters: :numeric}
    CSV.foreach(file_path, options ) do |merchant|
      merchants << Merchant.new(merchant.to_h, self)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

end

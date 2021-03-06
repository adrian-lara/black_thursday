require_relative 'item'
require 'bigdecimal'
require 'csv'

class ItemRepository

  attr_reader :items,
              :parent

  def initialize(file_path, parent = nil)
    @items = []
    load_csv(file_path)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def load_csv(file_path)
    options = {headers: true, header_converters: :symbol, converters: :numeric}
    CSV.foreach(file_path, options ) do |item|
      items << Item.new(item.to_h, self)
    end
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

end

require_relative 'customer'
require 'csv'

class CustomerRepository

  attr_reader :all, :parent

  def initialize(file_path, parent = nil)
    @all = from_csv(file_path)
    @parent = parent
  end

  def from_csv(file_path)
    customers = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol, converters: :numeric ) do |row|
      customers << Customer.new(row, self)
    end
    customers
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    @all.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    @all.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @all.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

end

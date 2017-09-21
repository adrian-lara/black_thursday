require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :ir

  def setup
    @ir = InvoiceRepository.new('./test/fixtures/invoices_truncated_56.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, ir
  end

  def test_ir_has_a_parent_defaulted_to_nil
    assert_nil ir.parent
  end

  def test_load_csv
    assert_equal 56, ir.invoices.length
    ir.load_csv('./test/fixtures/invoices_truncated_56.csv')

    assert_equal 112, ir.invoices.length
  end

  def test_inspect_returns_class_and_row_count
    assert_equal "#<InvoiceRepository 56 rows>", @ir.inspect
  end

  def test_invoices_returns_array
    actual = ir.invoices

    assert_instance_of Invoice, actual[0]
    assert_instance_of Invoice, actual[-1]
    assert_equal 56, actual.length
  end

  def test_all_returns_array_of_all_invoices
    actual = ir.all

    assert_instance_of Invoice, actual[0]
    assert_instance_of Invoice, actual[-1]
    assert_equal 56, actual.length
  end

  def test_find_by_id_returns_nil_with_invalid_id
    actual = ir.find_by_id(666)

    assert_nil actual
  end

  def test_find_by_id_returns_invoice_with_valid_id
    actual = ir.find_by_id(10)
    expected = ir.invoices[9]

    assert_equal expected, actual
  end

  def test_find_all_by_customer_id_returns_empty_array_with_invalid_customer_id
    actual = ir.find_all_by_customer_id(666)

    assert_equal [], actual
  end

  def test_find_all_by_customer_id_returns_customer_with_valid_customer_id
    actual = ir.find_all_by_customer_id(2)
    expected = [ir.invoices[8], ir.invoices[9]]

    assert_equal expected, actual
  end

  def test_find_all_by_merchant_id_returns_empty_array_with_invalid_merchant_id
    actual = ir.find_all_by_merchant_id(666)

    assert_equal [], actual
  end

  def test_find_all_by_merchant_id_returns_merchants_array_with_valid_merchant_id
    actual = ir.find_all_by_merchant_id(12334105)
    expected = [ir.invoices[0]]

    assert_equal expected, actual
  end

  def test_find_all_by_status_returns_empty_array_with_invalid_status
    actual = ir.find_all_by_status("queued")

    assert_equal [], actual
  end

  def test_find_all_by_status_returns_array_of_invoices_with_valid_status_search
    actual = ir.find_all_by_status("shipped")
    expected = [ir.invoices[1], ir.invoices[2], ir.invoices[7], ir.invoices[8]]

    assert_equal expected, actual
  end

end

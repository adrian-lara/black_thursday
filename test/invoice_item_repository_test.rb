require_relative 'test_helper'
require './lib/invoice_item_repository'
require './lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @iir = InvoiceItemRepository.new("./test/fixtures/invoice_items_truncated_10.csv")
  end

  def test_invoice_item_repository_class_exist
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_invoice_item_repository_is_initialized_with_an_array_populated_by_from_csv
    assert_equal 10, @iir.all.count
  end

  def test_invoice_item_is_initilialized_with_a_parent_defaulted_to_nil
    assert_nil @iir.parent
  end

  def test_inspect_returns_class_and_row_count
    assert_equal "#<InvoiceItemRepository 10 rows>", @iir.inspect
  end

  def test_data_item_id_4_returns_correct_matching_item_id
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")

    assert_equal 263396013, @iir.all[3].item_id
  end

  def test_data_item_id_8_returns_correct_matching_quantity
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")

    assert_equal 6, @iir.all[8].quantity
  end

  def test_data_item_id_5_returns_correct_matching_unit_price
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")

    assert_equal 791.40, @iir.all[4].unit_price
  end

  def test_find_by_id_returns_instance_of_invoice_item_that_has_given_id
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")
    actual = @iir.find_by_id(3)
    expected = 263395617

    assert_equal expected, actual.item_id
  end

  def test_find_by_id_returns_nil_if_there_is_no_matching_id
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")
    assert_nil @iir.find_by_id("11")
  end

  def test_find_all_by_item_id_returns_array_of_invoice_items_matching_id
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")
    actual = @iir.find_all_by_item_id(263396517)
    expected = [@iir.all[-2]]

    assert_equal expected, actual
  end

  def test_find_all_by_item_id_returns_empty_array_if_no_invoice_items_has_given_item_id
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")
    actual = @iir.find_all_by_item_id(263396517)
    expected = [@iir.all[-2]]

    assert_equal expected, actual
  end

  def test_find_all_by_invoice_id_returns_array_of_invoice_items_with_matching_invoice_id
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")
    actual = @iir.find_all_by_invoice_id(2)
    expected = [@iir.all[-2], @iir.all[-1]]

    assert_equal expected, actual
  end

  def test_find_all_by_invoice_id_returns_empty_array_if_no_invoice_items_has_given_invoice_id
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")
    actual = @iir.find_all_by_invoice_id("3")
    expected = []

    assert_equal expected, actual
  end
end

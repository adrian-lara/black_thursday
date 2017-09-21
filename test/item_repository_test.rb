require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader :ir

  def setup
    @ir = ItemRepository.new('./test/fixtures/items_truncated_3.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, ir
  end

  def test_parent_exist_and_defaults_to_nil
    actual = @ir.parent

    assert_nil actual
  end

  def test_load_csv
    assert_equal 3, ir.items.length
    ir.load_csv('./test/fixtures/items_truncated_3.csv')

    assert_equal 6, ir.items.length
  end

  def test_inspect_returns_class_and_row_count
    assert_equal "#<ItemRepository 3 rows>", @ir.inspect
  end

  def test_items_returns_array
    actual = ir.items

    assert_instance_of Item, actual[0]
    assert_instance_of Item, actual[1]
    assert_instance_of Item, actual[2]
    assert_equal 3, actual.length
  end

  def test_all_returns_array_of_items
    actual = ir.all

    assert_instance_of Item, actual[0]
    assert_instance_of Item, actual[1]
    assert_instance_of Item, actual[2]
    assert_equal 3, actual.length
  end

  def test_find_by_id_returns_nil_with_invalid_id
    actual = ir.find_by_id(666)

    assert_nil actual
  end

  def test_find_by_id_returns_item_with_valid_id
    actual = ir.find_by_id(263395237)
    expected = ir.items[0]

    assert_equal expected, actual
  end

  def test_find_by_name_returns_nil_with_invalid_name
    actual = ir.find_by_name("invalid")

    assert_nil actual
  end

  def test_find_by_name_returns_item_with_valid_name
    actual = ir.find_by_name("510+ RealPush Icon Set")
    expected = ir.items[0]

    assert_equal expected, actual
  end

  def test_find_by_name_returns_item_with_valid_name_case_insensitive
    actual = ir.find_by_name("510+ realpush icon set")
    expected = ir.items[0]

    assert_equal expected, actual
  end

  def test_find_all_with_description_returns_empty_array_with_invalid_search
    actual = ir.find_all_with_description("people")

    assert_equal [], actual
  end

  def test_find_all_with_description_returns_items_with_valid_search_case_insensitive
    actual = ir.find_all_with_description("Glitter")
    expected = [ir.items[1], ir.items[2]]

    assert_equal expected, actual
  end

  def test_find_all_by_price_returns_empty_array_with_invalid_search
    actual = ir.find_all_by_price(199)

    assert_equal [], actual
  end

  def test_find_all_by_price_returns_item_with_valid_search
    actual = ir.find_all_by_price(12)
    expected = [ir.items[0]]

    assert_equal expected, actual
  end

  def test_find_all_price_in_range_returns_empty_array_with_invalid_range
    actual = ir.find_all_by_price_in_range((50..100))

    assert_equal [], actual
  end

  def test_find_all_by_price_in_range_returns_items_with_valid_range
    actual = ir.find_all_by_price_in_range((13..14))
    expected = [ir.items[1], ir.items[2]]

    assert_equal expected, actual
  end

  def test_find_all_by_merchant_id_returns_empty_array_invalid_search
    actual = ir.find_all_by_merchant_id(666)

    assert_equal [], actual
  end

  def test_find_all_by_merchant_id_returns_item_with_valid_search
    actual = ir.find_all_by_merchant_id(12334185)
    expected = [ir.items[2]]

    assert_equal expected, actual
  end

end

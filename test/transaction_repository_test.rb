require_relative 'test_helper'
require './lib/transaction'
require './lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test

  def setup
    @trxr = TransactionRepository.new("./test/fixtures/transaction_truncated_10.csv")
  end

  def test_transaction_reposirtory_class_exist
    assert_instance_of TransactionRepository, @trxr
  end

  def test_from_csv_populates_data
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")

    assert_equal 10, @trxr.all.count
  end

  def test_trx_cvs_item_4_returns_correct_matching_id
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")

    assert_equal 4, @trxr.all[3].invoice_id
  end

  def test_trx_cvs_item_7_returns_correct_matching_credit_card
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")

    assert_equal 4613250127567219, @trxr.all[6].credit_card_number
  end

  def test_trx_cvs_item_10_returns_correct_matching_result
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")

    assert_equal "success", @trxr.all[9].result
  end

  def test_find_by_id_returns_instance_of_transaction_item
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")
    actual = @trxr.find_by_id(3)
    expected = 3

    assert_equal expected, actual.invoice_id
  end

  def test_find_by_id_returns_nil_if_there_is_no_matching_id
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")
    assert_nil @trxr.find_by_id("11")
  end

  def test_find_all_by_credit_card_number_returns_array_of_transactions_associated_with_given_cc_num
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")
    actual = @trxr.find_all_by_credit_card_number(4068631943231473)
    expected = @trxr.all[0..1]

    assert_equal expected, actual
  end

  def test_find_all_by_invoice_id_returns_array_of_invoice_items_matching_id
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")
    actual = @trxr.find_all_by_invoice_id(4)
    expected = [@trxr.all[3]]
    assert_equal expected, actual
  end

end

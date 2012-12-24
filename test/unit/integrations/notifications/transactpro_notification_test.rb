require 'test_helper'

class TransactproNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @transactpro = Transactpro::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @transactpro.complete?
    assert_equal "", @transactpro.status
    assert_equal "", @transactpro.transaction_id
    assert_equal "", @transactpro.item_id
    assert_equal "", @transactpro.gross
    assert_equal "", @transactpro.currency
    assert_equal "", @transactpro.received_at
    assert @transactpro.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'USD'), @transactpro.amount
  end

  # Replace with real successful acknowledgement code
  def test_acknowledgement

  end

  def test_send_acknowledgement
  end

  def test_respond_to_acknowledge
    assert @transactpro.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    ""
  end
end

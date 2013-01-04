require 'test_helper'

class TransactproModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
    assert_instance_of Transactpro::Notification, Transactpro.notification('name=cody')
  end

  def test_test_mode
    ActiveMerchant::Billing::Base.integration_mode = :test
    assert_equal 'https://87.110.182.18:8443', Transactpro.service_url
  end

  def test_production_mode
    ActiveMerchant::Billing::Base.integration_mode = :production
    assert_equal 'https://www2.1stpayments.net', Transactpro.service_url
  end

  def test_invalid_mode
    ActiveMerchant::Billing::Base.integration_mode = :bro
    assert_raise(StandardError){ Transactpro.service_url }
  end

end

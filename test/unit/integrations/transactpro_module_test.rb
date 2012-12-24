require 'test_helper'

class TransactproModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
    assert_instance_of Transactpro::Notification, Transactpro.notification('name=cody')
  end
end

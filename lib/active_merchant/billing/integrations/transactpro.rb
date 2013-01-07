require File.dirname(__FILE__) + '/transactpro/common.rb'
require File.dirname(__FILE__) + '/transactpro/transaction.rb'
require File.dirname(__FILE__) + '/transactpro/helper.rb'
require File.dirname(__FILE__) + '/transactpro/notification.rb'
require File.dirname(__FILE__) + '/transactpro/status.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro

        mattr_accessor :test_service_url
        self.test_service_url = 'https://87.110.182.18:8443'

        mattr_accessor :production_service_url
        self.production_service_url = 'https://www2.1stpayments.net'

        class << self

          def test?
            ActiveMerchant::Billing::Base.integration_mode == :test ? true : false
          end

          def create_transaction_url
            %{#{service_url}/#{ test? ? 'gw2test/' : '' }gwprocessor2.php?a=init}
          end

          def status_url
            %{#{service_url}/#{ test? ? 'gw2test/' : '' }gwprocessor2.php?a=status_request}
          end

          def service_url
            mode = ActiveMerchant::Billing::Base.integration_mode
            case mode
            when :production
              self.production_service_url
            when :test
              self.test_service_url
            else
              raise StandardError, "Integration mode set to an invalid value: #{mode}"
            end

          end

          def notification(post)
            Notification.new(post)
          end

        end # end class << self

      end
    end
  end
end

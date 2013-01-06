require File.dirname(__FILE__) + '/transactpro/common.rb'
require File.dirname(__FILE__) + '/transactpro/transaction.rb'
require File.dirname(__FILE__) + '/transactpro/helper.rb'
require File.dirname(__FILE__) + '/transactpro/notification.rb'
require File.dirname(__FILE__) + '/transactpro/status.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro

        # self.test_service_url = 'https://87.110.182.18:8443/gw2test/gwprocessor2.php'
        # self.production_service_url = 'https://www2.1stpayments.net/gwprocessor2.php'

        mattr_accessor :test_service_url
        self.test_service_url = 'https://87.110.182.18:8443'

        mattr_accessor :production_service_url
        self.production_service_url = 'https://www2.1stpayments.net'

        def self.create_transaction_url
          case ActiveMerchant::Billing::Base.integration_mode
          when :production
            %{#{service_url}/gwprocessor2.php?a=init}
          when :test
            %{#{service_url}/gw2test/gwprocessor2.php?a=init}
          end
        end

        def self.status_url
          case ActiveMerchant::Billing::Base.integration_mode
          when :production
            %{#{service_url}/gwprocessor2.php?a=status_request}
          when :test
            %{#{service_url}/gw2test/gwprocessor2.php?a=status_request}
          end
        end

        def self.service_url

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

        def self.notification(post)
          Notification.new(post)
        end
      end
    end
  end
end

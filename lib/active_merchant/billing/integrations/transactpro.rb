require File.dirname(__FILE__) + '/transactpro/helper.rb'
require File.dirname(__FILE__) + '/transactpro/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro


        mattr_accessor :test_service_url
        self.service_url = 'https://87.110.182.18:8443/gw2test/gwprocessor2.php?a=init'

        mattr_accessor :production_service_url
        self.service_url = 'https://www2.1stpayments.net/gwprocessor2.php?a=init'

        def self.service_url

          mode = ActiveMerchant::Billing::Base.integration_mode
          case mode
          when :production
            self.production_url
          when :test
            self.test_url
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

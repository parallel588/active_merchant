module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          # Replace with the real mapping
          mapping :account, 'guid'
          mapping :amount, 'amount'
          mapping :currency, 'currency'
          mapping :order, 'merchant_transaction_id'

          mapping :customer, :first_name => '',
                             :last_name  => '',
                             :email      => '',
                             :phone      => ''

          mapping :billing_address, :city     => '',
                                    :address1 => '',
                                    :address2 => '',
                                    :state    => '',
                                    :zip      => '',
                                    :country  => ''

          mapping :notify_url, ''
          mapping :return_url, ''
          mapping :cancel_return_url, ''
          mapping :description, 'description'
          mapping :tax, ''
          mapping :shipping, ''
        end
      end
    end
  end
end

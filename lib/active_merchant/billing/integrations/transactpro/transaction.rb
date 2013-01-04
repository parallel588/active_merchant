module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro
        class Transaction
          include PostsData

          # @param [Hash] config: quid, pwd, rs and etc
          #
          def initialize(config, id = nil)
            @config = config
            @id = id
          end

          # @param [Hash] fields
          #
          def create(fields)
            data = ActiveMerchant::PostData[fields]
            ssl_post(Transactpro.create_transaction_url, data.to_post_data )
          end


        end
      end
    end
  end
end

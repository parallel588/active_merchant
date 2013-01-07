module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro

        class Status
          include PostsData
          include Validateable

          attr_accessor :guid, :password, :f_extended
          attr_accessor :transaction_id, :response

          def status
            response["Status"]
          end

          def success?
            status == 'Success'
          end

          def update!
            data = PostData.new
            data[:f_extended] = self.f_extended || 5
            data[:init_transaction_id] = self.transaction_id
            data[:request_type] = 'transaction_status'
            data[:guid] = self.guid
            data[:pwd] = Common.pwd_hash(self.password)
            @response = ssl_post(Transactpro.status_url, data.to_post_data)
          end

          def response
            update! unless @response
            Common.parse_raw_response(@response)
          end

        end

      end
    end
  end
end

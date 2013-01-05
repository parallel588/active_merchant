module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro
        module Common

          #  SHA1 hash of your processing password.
          def self.pwd_hash(pwd)
            Digest::SHA1.hexdigest(pwd.to_s)
          end

          def self.parse_raw_response(raw_body)
            Hash[*raw_body.to_s.split('~').map{|j|j.split(/:/, 2)}.flatten]
          end

        end
      end
    end
  end
end

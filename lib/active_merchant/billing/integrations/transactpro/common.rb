module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro
        module Common

          #  SHA1 hash of your processing password.
          def pwd_hash(pwd)
            Digest::SHA1.hexdigest(pwd.to_s)
          end
        end
      end
    end
  end
end

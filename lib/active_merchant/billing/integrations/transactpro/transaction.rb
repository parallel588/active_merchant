# ActiveMerchant::Billing::Integrations::Transactpro::Transaction
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Transactpro
        class Transaction
          include PostsData
          include Validateable

          DEFAULT_CURRENCY = 'USD'

          attr_accessor :guid, :password, :routing_string, :currency, :merchant_site_url, :f_extended, :save_card
          attr_accessor :merchant_transaction_id,  :user_ip, :amount
          attr_accessor :name_on_card, :description, :street, :zip, :city, :country, :state, :email, :phone

          # # @param [Hash] config: quid, pwd, rs and etc
          # #
          # def initialize(config, id = nil)
          #   @config = config
          #   @id = id
          # end

          # @param [Hash] fields
          #
          def create

            data = ActiveMerchant::PostData[{
                                              guid: self.guid,
                                              pwd: Common.pwd_hash(self.password),
                                              rs: self.routing_string,
                                              currency: currency,
                                              merchant_site_url: self.merchant_site_url,
                                              f_extended: (self.f_extended||5),
                                              save_card: 0,
                                              merchant_transaction_id: self.merchant_transaction_id,
                                              user_ip: self.user_ip,
                                              amount: self.amount,
                                              name_on_card: self.name_on_card,
                                              description: description,
                                              street: self.street,
                                              zip: self.zip,
                                              city: self.city,
                                              country: self.country,
                                              state: self.state,
                                              phone: self.phone
                                            }]

            data[:email] = self.email if self.email.present?
            @response = ssl_post(Transactpro.create_transaction_url, data.to_post_data )

          end

          def currency
            (ActiveMerchant::Billing::Base.integration_mode == :test ? DEFAULT_CURRENCY : (@currency || DEFAULT_CURRENCY) )
          end

          def before_validate
            state = 'NA' if self.state.blank?
          end

          def validate
            [:guid, :password, :routing_string, :city, :name_on_card, :state, :street, :zip, :user_ip, :amount, :phone ].each do |attr|
              errors.add(attr, "cannot be empty") if self.send(attr).blank?
            end

            errors.add(:user_ip, "is invalid") unless !!user_ip.to_s.match(/\A(?:[0-9]{1,3}\.){3}[0-9]{1,3}\Z/)

            if (ActiveMerchant::Billing::Base.integration_mode == :test) && (amount > 100000)
              errors.add(:amount, 'must be less $ 1000 for test mode')
            end

            errors.add(:description, 'must be from 5 to 255 characters') unless (5..255).include?(description.to_s.size)
            errors.add(:phone, 'must be greater than 5 characters') unless photo.to_s.size > 5
          end

        end
      end
    end
  end
end

# frozen_string_literal: true

# email:string
# password_digest:string
#
# password:string virtual
# password_confirmation:string virtual

class User < ApplicationRecord
  has_many :twitter_accounts
  has_many :tweets

  has_secure_password
  # line below validates for presence of e-mail address, what is relevant for further account finding
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be valid email address' }
end

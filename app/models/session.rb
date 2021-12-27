class Session < ApplicationRecord
  belongs_to :user
  # TODO: token attribute must be encoded
end

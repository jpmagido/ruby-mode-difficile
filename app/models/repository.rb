class Repository < ApplicationRecord
  belongs_to :cloud_storage, polymorphic: true
end

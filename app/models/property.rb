class Property < ApplicationRecord
  has_many :nearest_stations, dependent: :destroy
end
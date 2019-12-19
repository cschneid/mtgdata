class Buylist < ApplicationRecord
  belongs_to :printing
  validates :vendor, inclusion: { in: %w[CK SCG] }
end

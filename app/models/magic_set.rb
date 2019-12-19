class MagicSet < ApplicationRecord
  # Returns a hash of {Set Name => Set Record}
  def self.cached
    Hash[
      MagicSet.all.map { |ms| [ms.name, ms] }
    ]
  end
end

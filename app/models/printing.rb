class Printing < ApplicationRecord
  belongs_to :magic_set, optional: true

  # Common, Uncommon, Rare, Mythic, Special
  validates :rarity, inclusion: { in: %w[C U R M S L] }

  before_create :create_merged_key
  def create_merged_key
    return true if self.merged_key

    key = name + magic_set.name + rarity
    if foil
      key += " FOIL"
    end
    self.merged_key = key
  end
end

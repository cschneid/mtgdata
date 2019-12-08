class CreateInitialSchema < ActiveRecord::Migration[6.0]
  def change
    create_table :magic_sets do |t|
      t.text :name
      t.text :code
    end

    # Each row is a unique printing of a card. So: "Lightning Bolt from Unlimited" or "Foil Opt from Ixalan"
    #
    # This does not try to take into account condition, or unique individual cards ("My Bolt signed by each opponent it killed")
    create_table :printings do |t|
      # the key from the various buylist scrapes. Like: "Vampire HexmageConspiracy (2014 Edition)U FOIL"
      t.text :merged_key, null: false

      # UUID in scryfall
      t.text :scryfall_id

      # Basic card details
      t.belongs_to :magic_set
      t.text :name
      t.boolean :foil
      t.text :rarity

      # Indexes
      t.index :merged_key, unique: true
      t.index :name
    end

    # Each row is a single buylist datapoint, from a single vendor.
    # "As of Dec 6, 2019, Card Kingdom was offering $230.00 cash for Gaea's Cradle"
    create_table :buylists do |t|
      t.references :printings

      t.text :vendor

      t.timestamp :valid_on

      t.decimal :price
      t.integer :quantity

      # For any one card, on a given timestamp, for a single vendor, there should only be a single value.
      t.index [:printings_id, :valid_on, :vendor], unique: true

      t.index [:valid_on, :vendor]
    end
  end
end

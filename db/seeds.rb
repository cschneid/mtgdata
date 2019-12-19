require_relative './sets.rb'

SETS.each do |set|
  MagicSet.create!(name: set)
end

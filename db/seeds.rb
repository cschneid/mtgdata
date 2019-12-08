require_relative './sets.rb'

SETS.each do |set|
  MagicSet.new(name: set)
end

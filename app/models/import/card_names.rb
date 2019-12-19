# Expects a no-header, 3 column csv. 
# key, name, set
# Key is parsed to extract rarity, and foil
# Key example: "Scythe TigerZendikarC FOI"
module Import
  class CardNames
    def self.import(csv)
      require 'csv'
      exceptions = []
      CSV.new(File.read(csv)).each do |row|
        puts "Parsing #{row.inspect}"

        # Extract
        key, name, set = row
        set = set.strip
        match = key.strip.match(/.*(?<rarity>[CURMSL])(?<foil>\s+FOIL?)?\z/)
        rarity = match[:rarity]
        foil = match[:foil].present?

        # Transform
        if !key.include? name
          name = nil
        end

        magic_set = if key.include?(set)
          MagicSet.find_by_name(set)
        else
          nil
        end

        # Load
        Printing.create!({
          merged_key: key.strip,
          name: name,
          magic_set: magic_set,
          rarity: rarity,
          foil: foil,
        })
      rescue => e
        exceptions << [e, row]
        puts "Exception on Row: #{row.inspect}: #{e}"
      end

      puts "Errors:"
      exceptions.each {|ex| puts ex.inspect}
    end
  end
end

require 'csv'
module Import
  class KodaBuylist
    def self.import(vendor, valid_on, file)
      errors = []
      sets = MagicSet.cached
      i = 0

      batch = BatchedWork.new(batch_size: 50) do |batch|
        puts "\nRunning batch (#{i}-#{i+batch.size})"
        Buylist.create!(batch)
        i = i + batch.size
      end

      csv = CSV.new(File.read(file), headers: true)
      csv.each do |row|
        begin
          name = row["Card Name"].strip
          set = row["Card Set"].strip
          foil = row["NF/F"].present?
          rarity = row["Rarity"].strip

          print "Imported #{name} - #{set} - #{foil}"

          magic_set = sets[set]
          raise "Missing Set" if magic_set.nil?

          printing_args = {
            name: name,
            magic_set: magic_set, 
            foil: foil,
            rarity: rarity,
          }
          printing = Printing.where(printing_args).first
          # if printing.nil?
          # printing = Printing.create!(printing_args.dup)
          # end
          raise "Missing Printing" if printing.nil?

          batch.add_to_batch(
            {
              printing: printing.dup,
              vendor: vendor,
              valid_on: valid_on,
              price: row["Price"],
              quantity: row["Quantity"]
            })
          puts "... Batched\n"

          STDOUT.flush
        rescue => e
          puts "... Failed - #{e} - #{row.inspect}\n"
          STDOUT.flush
          errors << e
        end

        puts errors.map(&:to_s).join("\n")
        errors
      end
    end
  end
end

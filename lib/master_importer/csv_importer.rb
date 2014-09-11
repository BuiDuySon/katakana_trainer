require "csv"
module MasterImporter
  class MasterImporter::CSVImporter

    def initialize model
      @model = model
    end

    def execute
      unless @model.count > 0
        destroy_all
        puts "== Load #{@model}"
        csv_table = CSV.parse(File.read(csv_file_path), headers: true)
        csv_table.each do |row|
          instance = @model.new
          row.to_hash.each do |key, value|
            instance[key] = value
          end
          instance.save!
        end
      end
    end

    private
    def destroy_all
      puts "== Destroy All of #{@model}"
      @model.destroy_all
    end

    def csv_file_path
      Rails.root.join "db", "masters", "#{@model.name.underscore.pluralize}.csv"
    end

  end
end

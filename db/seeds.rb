require "master_importer/csv_importer"

# Master Datas
[M::Word].each do |model|
  MasterImporter::CSVImporter.new(model).execute
end

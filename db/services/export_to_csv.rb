require 'csv'
require_relative 'connect_to_db'

# options
table_name = :proc_collage_summaries
columns = [:collage_id, :collage_scrap_count, :total_images]
#rows = { method: "lim", value: 5 } # lim, row limit
rows = { method: "fil", value: "collage_scrap_count > 4" }

db = ConnectToDB.call

source = db[table_name]

exportable = source.select(columns.delete_at(0))

columns.each do |col|
  exportable = exportable.select_append(col)
end

exportable = exportable.limit(rows[:value]) if rows[:method] == "lim"
exportable = exportable.where(rows[:value]) if rows[:method] = "fil"

CSV.open("file.csv", 'w') do |csv|
  csv << exportable.columns
  exportable.each do |record|
    csv << record.values
  end
end

puts "The output has #{exportable.count} and #{exportable.columns.size}."
puts exportable.first

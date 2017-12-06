#!/usr/bin/env ruby

require 'json'

file      = ARGV[0] || 'small.json'
keys      = []
row_count = 0
files_per_directory = 5000
output    = true
last_file_number = 10000

data_as_string = File.read(file).encode('UTF-8', :invalid => :replace)
data_as_hash = JSON.parse(data_as_string)

data_as_hash["meta"]["view"]["columns"].each do |column|
  better_name = column["name"].gsub(" ", "-").downcase
  if better_name == "consumer-complaint-narrative"
    better_name = "text"
  end
  if better_name == "id"
    better_name = "source_id"
  end
  keys << better_name
end

output_dir_name = "json_output"
if output && !File.exist?(output_dir_name)
  `mkdir #{output_dir_name}`
end

data_as_hash["data"].each do |listing|
  row_count = row_count + 1
  output_hash = {}
  listing.each_with_index do |value, i|
    output_hash[keys[i]] = value
  end

  sub_dir = row_count / files_per_directory
  sub_dir_name = "#{output_dir_name}/#{sub_dir}"
  if output && !File.exist?(sub_dir_name)
    `mkdir #{sub_dir_name}`
  end

  if output
    File.open("#{sub_dir_name}/file#{row_count}.json", 'w') do |file|
      file.puts JSON.pretty_generate(output_hash)
    end
  else
    puts JSON.pretty_generate(output_hash)
  end
  
  if row_count == last_file_number
    break
  end
end
require 'csv'
require 'sunlight/congress'

# lines = File.readlines "event_attendees.csv"
# lines.map! do |line|
#   line.split(',')
# end
# lines.each_with_index do |line, idx|
#   next if idx == 0
#   puts line[2]
# end

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode zipcode
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode zipcode
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  legislator_names = legislators.map do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end
  legislator_names.join(', ')
end

contents = CSV.open "event_attendees.csv", headers: true,
                    header_converters: :symbol
contents.each do |row|
  first_name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislator_string = legislators_by_zipcode(zipcode)

  puts "#{first_name} #{zipcode} #{legislator_string}"

  sleep 1
end

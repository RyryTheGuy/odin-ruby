require "csv"
require "google/apis/civicinfo_v2"
require "erb"
require "date"

# Cleans up invalid zipcodes and returns valid zipcodes
def clean_zipcode(zipcode)
  # if zipcode.nil? 
  #   zipcode = "00000"
  # elsif zipcode.length < 5
  #   zipcode = zipcode.rjust(5, "0")
  # elsif zipcode.length > 5
  #   zipcode = zipcode[0..4]
  # end
  
  zipcode.to_s.rjust(5, "0")[0..4]
end

def validate_phone_number(phone_number)
  # Reformat all phone numbers to be the same
  phone_number.gsub!(/\D/, "")
  
  if phone_number.length < 10 || phone_number.length > 11
    return "Invalid Number"
  elsif phone_number.length == 11
    return phone_number[0] == "1" ? phone_number[1..10] : "Invalid Number"
  end

  phone_number
end

def get_hour_registered(time_string)
  DateTime.strptime(time_string, '%m/%d/%y %H:%M').hour
end

def get_wday_registered(time_string)
  case DateTime.strptime(time_string, '%m/%d/%y %H:%M').wday
  when 0
    "Sunday"
  when 1
    "Monday"
  when 2
    "Tuesday"
  when 3
    "Wednesday"
  when 4
    "Thursday"
  when 5
    "Friday"
  when 6
    "Saturday"
  end
end

def legislators_by_zipcode(zip)
  # Civic API info
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
  
  # Begin/rescue like Try/Catch - Run what's in the begin clause but if there is an exception then run the rescue clause
  begin
    # Civic API
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

# Saves thank you letters for every event attendee
def save_thank_you_letter(id, form_letter)
  # Creates an output directory if there isn't one
  Dir.mkdir("output") unless Dir.exists?("output")
  
  # File name created by specific id's
  filename = "output/thanks_#{id}.html"
  
  # Create the file and write the personalized form letter to it
  File.open(filename, 'w') do |file|
    file.puts(form_letter)
  end 
end

# Lets the user know the program has ran
puts "Event Manager Initialized."

# Uses CSV gem, reads the csv file, sorts the data by the headers
contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

# Reads the 'form_letter.erb' text
template_letter = File.read("form_letter.erb")
# Creates an ERB object - ERB is a template language allowing actual Ruby code to be added to any text document
erb_template = ERB.new(template_letter)

popular_hours = Hash.new(0)
popular_wday = Hash.new(0)

# Loop through the event attendees. Every row is an attendee
contents.each do |row|
  # Grab the attendee's id, name, zipcode, and array with their cities legislators (if any)
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = validate_phone_number(row[:homephone])
  popular_hours[get_hour_registered(row[:regdate])] += 1
  popular_wday[get_wday_registered(row[:regdate])] += 1
  legislators = legislators_by_zipcode(zipcode)

  # Binding knows all the variables within the current scope. 
  # By passing it into erb_template.result(), we pass all the instance variables into the erb template letter to be used
  # Returning the erb template letter without the ruby code within
  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

# p popular_wday
# p popular_hours
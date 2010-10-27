require_relative 'lib/meeting'

DATA_FILE = "student_availability.csv"

meeting =  Meeting.new(DATA_FILE)
Meeting::DAYS.each_key do |day|
  meeting.generate_file_meeting_time_on(day, "#{day}-roster.txt")
end

puts "========== Gernate files completed =========="


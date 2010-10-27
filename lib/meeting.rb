require 'csv'
require_relative 'student'

class Meeting
  attr_reader :students
  
  DAYS = {
    :monday => "Monday Availability",
    :wednesday => "Wednesday Availability"
  }
  
  def initialize(data_file)
    @students = []
    
    @availability_meeting_times = {:monday => {}, :wednesday => {}}
    
    parse_data(data_file)
  end
  
  def availability_meeting_times_on(day)
    @availability_meeting_times[day]
  end
  
  def find_meeting_time_on(day)
    @availability_meeting_times[day].max_by do |k, students|
      students.length
    end
  end
  
  def generate_file_meeting_time_on(day, file_name)
    meeting_time = find_meeting_time_on(day)
    
    File.open(file_name, "w") do |file|
      file.puts meeting_time[0]
      file.puts "\n"
      
      meeting_time[1].each do |student|
        file.puts student.name
      end
    end
  end
  
  private
  def parse_data(data_file)
    CSV.foreach(data_file, :headers => :first_row) do |row|        
      parse_availability_meeting_times(row)
    end
  end
    
  def parse_availability_meeting_times(row)
    student = append_student(row["Name"])
    
    DAYS.each_key do |day|
      parse_meeting_times(DAYS[day], row).each do |time|          
        @availability_meeting_times[day][time] ||= []
        @availability_meeting_times[day][time] << student
      end
    end
  end
  
  def append_student(name)
    @students << Student.new(name)
    
    @students.last
  end

  
  def parse_meeting_times(day, row)
    row[day].split(",").inject([]) do |meeting_times, time|
      meeting_times << time.strip
    end
  end
end

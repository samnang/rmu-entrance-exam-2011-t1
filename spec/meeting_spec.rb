require 'spec_helper'

describe Meeting do
  DATA_FILE = File.join(File.dirname(__FILE__), '..', 'student_availability.csv')
  
  let(:meeting) { Meeting.new(DATA_FILE) }
    
  context "when load all students from csv" do    
    it { meeting.should have(18).students }
        
    it "should parse student name correctly" do
      first_student_name = "Mylene Wilkinson"      
      
      meeting.students[0].name.should == first_student_name
    end
    
    it "should parse meeting times" do      
      meeting.availability_meeting_times_on(:monday).first.should have_at_least(1).student
      meeting.availability_meeting_times_on(:wednesday).first.should have_at_least(1).student
    end    
  end

  describe "#find_meeting_time_on" do        
    it "Monday should return the meeting time that most students are available" do
      meeting.find_meeting_time_on(:monday)[0].should == "3:00 pm EDT (19:00 UTC)"
      meeting.find_meeting_time_on(:monday)[1].should have_at_least(1).student
    end
    
    it "Wednesday should return the meeting time that most students are available" do
      meeting.find_meeting_time_on(:wednesday)[0].should == "12:00 pm EDT (16:00 UTC)"
      meeting.find_meeting_time_on(:wednesday)[1].should have_at_least(1).student
    end    
  end    
end

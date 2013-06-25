class Request < Lesson
  # validate :number_of_meetings

  # def number_of_meetings
  #   if self.meetings.reject(&:marked_for_destruction?).length < 1
  #     errors.add(:meetings, "- please add at least 1 meeting time")
  #   end
  # end
end
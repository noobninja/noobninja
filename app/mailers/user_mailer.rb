class UserMailer < ActionMailer::Base
  default from: "NoobNinja <sensei@noobninja.com>"

  def meeting_request_email(requester, reciever, request)
    @requester = requester
    @reciever = reciever
    @request = request
    @url = meeting_url(request.meetings.first)
    mail(to: @reciever.email, subject: "#{@requester.first_name} has just requested one of your lessons.")
  end

  def meeting_booked_email(requester, reciever, meeting)
    @requester = requester
    @reciever = reciever
    @meeting = meeting
    @lesson = @meeting.lesson
    @url = meeting_url(@meeting)
    mail(to: @reciever.email, subject: "#{@requester.first_name} has just booked one of your lessons.")
  end

  def meeting_confirmation_email(requester, reciever, meeting)
    @requester = requester
    @reciever = reciever
    @meeting = meeting
    @lesson = @meeting.lesson
    @url = meeting_url(@meeting)
    mail(to: @reciever.email, subject: "You've just booked a lesson.")
  end
end

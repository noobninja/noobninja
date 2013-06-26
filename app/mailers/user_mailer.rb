class UserMailer < ActionMailer::Base
  default from: "NoobNinja <sensei@noobninja.com>"

  def meeting_request_email(requester, reciever, request)
    @requester = requester
    @reciever = reciever
    @request = request
    @url = meeting_url(request.meetings.first)
    mail(to: @reciever.email, subject: "#{@requester.first_name} has just requested one of your lessons.")
  end
end

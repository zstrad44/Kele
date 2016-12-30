require "httparty"
require "json"
require_relative "kele/roadmap"

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)

    @api_url = 'https://www.bloc.io/api/v1'
    receive = self.class.post(@api_url + '/sessions',
      body: {
        'email': email,
        'password': password
      })

    raise ArgumentError, "Email or password is invalid, please try again" unless receive.code == 200
    @auth_token = receive["auth_token"]
  end

  def get_me

    receive = self.class.get(@api_url + '/users/me', headers: { "authorization" => @auth_token })

    JSON.parse(receive.body)
  end

  def get_mentor_availability(mentor_id)

    receive = self.class.get(@api_url + '/mentors/' + mentor_id.to_s  + '/student_availability', headers: { "authorization" => @auth_token })

    JSON.parse(receive.body).to_a

  end

  def get_messages(page)
    receive = self.class.get(@api_url + '/message_threads/', headers: { "authorization" => @auth_token }, body: {"page": page })
    @messages = JSON.parse(receive.body)
  end

  def create_message(sender, recipient_id, token, subject, body)
   receive = self.class.post(@api_url + '/messages',
     headers: { "authorization" => @auth_token },
       body: {
         "sender": sender,
         "recipient_id": recipient_id,
         "token": token,
         "subject": subject,
         "stripped-text": body})
  end

  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id,  comment, enrollment_id)
    receive = self.class.post(@api_url + '/checkpoint_submissions',
      headers: { "authorization" => @auth_token },
       body: {
         "assignment_branch": assignment_branch,
         "assignment_commit_link": assignment_commit_link,
         "checkpoint_id": checkpoint_id,
         "comment": comment,
         "enrollment_id": @enrollment_id })
  end
end

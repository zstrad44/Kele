require "httparty"

class Kele
  include HTTParty

  def initialize(email, password)
    @email = email
    @password = password
    @api_url = 'https://www.bloc.io/api/v1/sessions'
    receive = self.class.post(@api_url + '/sessions', body: { email: @email, password: @password })

      unless receive.code == 200

           if receive.code == 404
               raise "Email or password is invalid, please try   again"
           end
       end
       @auth_token = receive["auth_token"]
  end
end

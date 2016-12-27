require "httparty"

class Kele
  include HTTParty

  def initialize(email, password)
    
    @api_url = 'https://www.bloc.io/api/v1'
    receive = self.class.post(@api_url + '/sessions', body: {  'email': email, 'password': password })

    raise ArgumentError, "Email or password is invalid, please try again" unless receive.code == 200
    @auth_token = receive["auth_token"]
  end
end

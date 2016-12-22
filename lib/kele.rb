require 'httparty'

class kele
  include HTTParty

  def initalize(email, password)
    @email = email
    @password = password
    @base_url = 'https://www.bloc.io/api/v1/sessions'
    @token = self.class.post(@base_url, body: { email: @email, password: @password })

  end
end

def set_facebook_omniauth()
  initial = {
    provider: "facebook",
    uid: "123456",
    info:
    {
      email: "test@test.com",
      name: "Test Name",
      image: "" },
   credentials:
    {token:
      "fakhwekjnf89ry93hfiueaflkjh2h21ygj21hb1kjGHJGJ12hj2ajRwZDZD",
      "expires_at"=>1503456789,
      "expires"=>true},
      "extra"=>{"raw_info"=>{"name"=>"Test Name", "email"=>"test@test.com", "id"=>"123456"}}
  }

  #enable OAuth testing
  OmniAuth.config.test_mode = true

  #fake facebook OmniAuth callback
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(initial)
end

def invalid_facebook_omniauth()
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
end

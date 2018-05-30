# This class help us random choose github's access token
class CredentialBalance
  def initialize(config)
    @config = config
    @access_list = @config.ACCESS_TOKEN
    @user_list = @config.USER_AGENT
    @rand_num = Random.rand(@access_list.length)
  end

  def set_random
    @rand_num = Random.rand(@access_list.length)
  end

  def access_token
    @access_list[@rand_num]
  end

  def user_agent
    @user_list[@rand_num]
  end
end

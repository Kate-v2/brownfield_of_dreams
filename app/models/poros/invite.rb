
class Invite

  attr_reader :invited

  def initialize(user, invited)
    @user    = user
    @invited = invited
    # can use an options hash instead and choose provider : github --> then this could interface with other services
  end

  def sender_github_name
    @user.github_username
  end

  def get_github_email
    get_single_github_user[:email]
  end

  def get_single_github_user
    request = { target: :one_user, username: @invited }
    request[:token] = @user.github_token
    GithubService.new(request).target_data
  end




end

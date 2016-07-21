class UserMailer < ActionMailer::Base
  default from: "admin@rottenmangoes.com"

  def deletion_email(user)
    @user = user
    @url = 'http://rottenmangoes.com/admin/users/destroy'
    mail(to: @user.email, subject: "Your Rotten Mangoes account has been removed by an administrator.") do |format|
      format.html { render 'deletion_email'}
    end
  end
end

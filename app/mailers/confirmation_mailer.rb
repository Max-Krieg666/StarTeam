class ConfirmationMailer < ApplicationMailer
  default template_path: 'mailers/confirmation_mailer'

  def send_confirmation(user, team)
    @user = user
    @team = team
    @url = confirmation_users_path, user: { confirmation_token: @user.confirmation_token }
    mail(to: @user.email, subject: I18n.t('mailers.registration'))
  end
end
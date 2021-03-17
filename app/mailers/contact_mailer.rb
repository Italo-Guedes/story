
class ContactMailer < ApplicationMailer

  def contact(form)
    @form = form
    mail(to: 'rafael@rdmapps.com.br', subject: 'Mensagem Rdmapps')
  end
end

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index contact]
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: nil, status: :ok }
    end
  end

  def about
  end

  def calendar
  end

  def calendar_events
    events = []
    10.times do |i|
      events << {
        title: "Evento #{i}",
        start: Time.zone.now.change(hour: i + 8),
        end: Time.zone.now.change(hour: i + 9),
        # url: url_for(current_user),
        # allDay: true,
        # classNames: 'event-red',
      }
    end
    render json: Oj.dump(events, mode: :compat), status: :ok
  end

  def contact
    create_struct_contact
    @contact = Struct::ContactUs.new(contact_params)

    respond_to do |format|
      if @contact.valid?
        ContactMailer.contact(@contact.to_h).deliver_later
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def contact_params
    params.require(:contact).permit(:email, :name, :message)
  end

  def create_struct_contact
    Struct.new('ContactUs', :email, :name, :message) do
      extend ActiveRecord::AttributeAssignment
      include ActiveModel::Model
      validates :email, :name, :message, presence: true

      validate do
        if email.present?
          self.errors.add(:email, 'inválido') if (self.email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i) != 0
        end
      end

      def initialize(contact_params)
        self.assign_attributes(contact_params)
      end
    end
  end
end

class AppointmentsController < ApplicationController
  before_action :validate_params, only: [:create]

  def index
    appointments = Appointment.where(client_id: current_user.id)
    render json: { appointments: appointments.map { |appo| serialize_appointment(appo) } }
  end

  def create
    time = DateTime.parse(time_params[:time])
    appointment = create_appointment(time)

    if appointment.save
      render json: { appointment: serialize_appointment(appointment) }, status: :created
    else
      render_error
    end
  end

  private

  def time_params
    params.permit(:time)
  end

  def create_appointment(time)
    Appointment.new(time: time,
                    client_id: current_user.id,
                    client_name: current_user.name,
                    driver: decide_driver(time))
  end

  def decide_driver(time)
    Appointment::POSSIBLE_DRIVERS.each do |driver|
      if Appointment.driver_working?(driver, time) && !Appointment.driver_busy?(driver, time)
        return driver
      end
    end
    nil
  end

  def serialize_appointment(appointment)
    {
      client_name: appointment.client_name,
      time: appointment.time
    }
  end

  def render_error
    render json: { error: 'no drivers available at that time' }, status: :unprocessable_entity
  end

  def validate_params
    render_error unless time_params[:time]
  end
end

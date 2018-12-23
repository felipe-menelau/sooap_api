class Appointment
  include Mongoid::Document
  field :client_name, type: String
  field :driver, type: String
  field :time, type: DateTime

  validates_presence_of :client_name, :driver, :time
end

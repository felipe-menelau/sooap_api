class Appointment
  POSSIBLE_DRIVERS = ['fullweek', 'weekdays'].freeze

  include Mongoid::Document
  field :client_name, type: String
  field :client_id, type: BSON::ObjectId
  field :driver, type: String
  field :time, type: DateTime

  validates_presence_of :client_name, :client_id, :driver, :time
  validates_inclusion_of :driver, in: POSSIBLE_DRIVERS
  validate :must_be_unique_in_interval

  def must_be_unique_in_interval
    return errors.add(:time, 'time is mandatory') if time.nil?
    errors.add(:time, 'driver is busy') if Appointment.driver_busy?(driver, time)
  end

  def self.driver_busy?(driver, time)
    start_time = time - 30.minutes
    end_time = time + 30.minutes
    count = Appointment.
              where(driver: driver).
              where(:time.gte => start_time,
                    :time.lte => end_time).
              count
    return true if count > 0
    false
  end

  def self.driver_working?(driver, time)
    return true if driver == 'fullweek'
    return true if driver == 'weekdays' && time.on_weekday?
    false
  end
end

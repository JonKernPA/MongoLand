require 'mongo_mapper'

class Proxy
  include MongoMapper::Document

  # Attributes ::::::::::::::::::::::::::::::::::::::::::::::::::::::
  key :proxy, Account
  key :from, Date
  key :to, Date

  # Associations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  belongs_to :account

  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  validates_presence_of :proxy

  # Check that the proxy is in effect
  def valid_over_dates?

    # Always valid if no dates specified
    return true if from.nil? && to.nil?

    today = Date.today

    if !from.nil? && to.nil? then
      return (today > from)
    end

    if !to.nil? && from.nil? then
      return (today <= to)
    end

    if !from.nil? && !to.nil? then
      return (from < today && today <= to)
    end

    return false
  end

  def to_s
    text = ""
    text += "#{proxy.name} is covering " unless proxy.nil?
    text += " From: " + (from.nil? ? "Now" : from.strftime("%a %d %b") )
    text += " To: " + (to.nil? ? "Eternity" : to.strftime("%a %d %b"))
  end

end

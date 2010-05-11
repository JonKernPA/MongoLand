require 'mongo_mapper'

class Group
  include MongoMapper::Document

  # Attributes ::::::::::::::::::::::::::::::::::::::::::::::::::::::
  key :name, String
  key :email, String

  # Associations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  many :accounts

  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  validates_presence_of :name
  
  def to_s
    "Group: #{name}"
  end

  def member_names
    text = ""
    accounts.each do |member|
      text << member.to_s << "\n"
    end
    text
  end
  
end

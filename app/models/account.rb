require 'mongo_mapper'

class Account
  include MongoMapper::Document

  # Attributes ::::::::::::::::::::::::::::::::::::::::::::::::::::::
  key :name, String
  key :email, String

  # Associations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  key :group_id, ObjectId
  belongs_to :group

  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  validates_presence_of :name
  validates_length_of   :email, :within => 6..100, :allow_blank => true, :allow_nil => true, :message => "is an invalid length"
  RegEmailName = '[\w\.%\+\-]+'
  RegDomainHead = '(?:[A-Z0-9\-]+\.)+'
  RegDomainTLD = '(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
  RegEmailOk = /\A#{RegEmailName}@#{RegDomainHead}#{RegDomainTLD}\z/i

  email_name_regex  = '[\w\.%\+\-]+'.freeze
  domain_head_regex = '(?:[A-Z0-9\-]+\.)+'.freeze
  domain_tld_regex  = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'.freeze
  email_regex       = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i
  bad_email_message = "should look like an email address ('user_name@somedomain.com')".freeze

  validates_format_of   :email, :with => email_regex, :allow_blank => true, :allow_nil => true, :message => bad_email_message

  def to_s
    name
  end
end

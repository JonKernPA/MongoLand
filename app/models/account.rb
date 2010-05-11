require 'mongo_mapper'

class Account
  include MongoMapper::Document

  # Attributes ::::::::::::::::::::::::::::::::::::::::::::::::::::::
  key :name, String
  key :email, String
  key :notify_me, Boolean, :default => false

  # Associations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  key :group_id, ObjectId
  belongs_to :group
  many :proxies

  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  validates_presence_of :name
  validates_length_of   :email, :within => 6..100, :allow_blank => true, :allow_nil => true, :message => "is an invalid length"

  email_name_regex  = '[\w\.%\+\-]+'.freeze
  domain_head_regex = '(?:[A-Z0-9\-]+\.)+'.freeze
  domain_tld_regex  = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'.freeze
  email_regex       = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i
  bad_email_message = "should look like an email address ('user_name@somedomain.com')".freeze

  validates_format_of   :email, :with => email_regex, :allow_blank => true, :allow_nil => true, :message => bad_email_message

  def email_list
    list = []
    list << email unless email.nil?
#    contacts.each { |contact| list << contact.email } if contacts.size > 0
    return list
  end

  # This returns a list of emails to be used for notifications
  # Notification list is based on contacts, group, and proxy -- constrained by notification prefs.
  def notification_list

    notification_email_list = []

    # Add My contacts
    if notify_me == true then
      notification_email_list = email_list
    end

#    # Add my Group contacts
#    if notify_group == true then
#      notification_email_list = notification_email_list | group.email_list unless group.email_list.nil?
#    end

    # Add my Proxy contacts
    if proxies.size > 0 then
      proxies.each do |designee|
        puts "Proxy: #{designee.to_s}"
        # Ensure From/To date range is adhered to
        if designee.valid_over_dates? == true then
          puts "in valid date range"
          # And we do not allow the proxy to have ourselves in their list (circular would not be good)
          notification_email_list << designee.proxy.email_list
#          notification_email_list << designee.proxy.notification_list.reject{|n| n == email}
        end
      end
    end

    return notification_email_list.flatten
  end
  
  def to_s
    name
  end
end

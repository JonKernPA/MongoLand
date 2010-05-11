# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mongoland_session',
  :secret      => '2ae24d0570047e2f8aa95ec63c162a85f761caf3ae1404b23477f753aae143a37237ac34eec0409b152a6d38b72be7f98b4f2b1865a399e311700b2a1684ed0a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

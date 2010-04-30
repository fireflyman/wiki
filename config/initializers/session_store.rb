# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wiki_session',
  :secret      => '3ac0e840d856e058bd767532d5ab57de6c69936d4fa5252a51ee4dbaf3da74601611e42d502b0b74dfe733f348ef95f21b141a1f75636e51096b80fac662323b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

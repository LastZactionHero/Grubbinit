# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_grubbinit_session',
  :secret      => 'b8b6f1b46c88404c8cd564948383827b24fe152c2e9de7629ef2536acde8ecee32659d0cec7d4a1ff5db574144bdbf945d17bc1f458552b4b1854a25a0755493'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

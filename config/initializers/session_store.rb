# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ruby-test_session',
  :secret      => '5951cc6b70ef710c98b275321bfdb358770698e009aa6d55d95f2e00b4a637b4464a4f8f3f446220154acaadcbb213956f5499cf71936ae5c02823346b974ad9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Rdmapps::Application.config.secret_key_base =
  '31a180da2f888e28705e72fe1e877eb816a0253fffae49309918d99a7e6c6063' \
  'f7574d6d4cd1db6f1358403e5746e61fca97492d38da743e48e3b38f8b4a6f8a'

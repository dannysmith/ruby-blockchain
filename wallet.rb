# frozen_string_literal: true

class Wallet
  attr_accessor :address, :name

  def initialize(pass_phrase:, name: 'default')
    @name = name
    @private_key, @public_key = generate_keypair(pass_phrase)
    @address = hash_public_key
  end

  private

  def hash_public_key
    Digest::SHA256.new.update(@public_key.to_s).hexdigest
  end

  def generate_keypair(passphrase)
    # This is a stub implementation of a public/private key generation
    priv = "privatekey#{passphrase}"
    pub = "publickey#{passphrase}"
    return [priv, pub]
  end
end

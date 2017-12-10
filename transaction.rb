# frozen_string_literal: true

class Transaction
  attr_reader :id, :from, :to, :payload, :qty, :timestamp

  def initialize(from:, to:, payload: 'BTC', qty: 1)
    @from = from
    @to = to
    @payload = payload
    @qty = qty
    @timestamp = Time.now
    @id = hash_transaction
  end

  def to_h
    {
      from: @from,
      to: @to,
      payload: @payload,
      qty: @qty,
      timestamp: @timestamp,
      id: @id
    }
  end

  private

  def hash_transaction
    sha = Digest::SHA256.new
    sha.update(@from.to_s + @to.to_s + @payload + @qty.to_s + @timestamp.to_s)
    sha.hexdigest
  end
end

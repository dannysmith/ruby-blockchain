
class Block
  attr_reader :index, :data, :previous_hash, :timestamp, :hash

  def initialize(index, data, previous_hash)
    @index = index
    @data = data
    @previous_hash = previous_hash
    @timestamp = Time.now
    @nonce, @hash = compute_hash_with_pow # Mrthod returns an array with 2 items
  end

  def to_h
    {
      index: @index,
      data: @data,
      previous_hash: @previous_hash,
      timestamp: @timestamp,
      hash: @hash
    }
  end

  # Class methods
  def self.__create(index:, data:, previous_hash:, timestamp:, hash:)
    block = self.new(index, data, previous_hash)
    block.instance_variable_set(:@timestamp, timestamp)
    block.instance_variable_set(:@hash, hash)
    block
  end

  private

  # If the hash starts with 00, we have a match. The longer this string is, the
  #  more work it will take to find one that matches, obviously.
  def compute_hash_with_pow(difficulty='00')
    nonce = 0
    loop do
      hash = calculate_hash(nonce)
      if hash.start_with?(difficulty)
        puts "Took #{nonce} attempts to find hash"
        return [nonce, hash]
      else
        nonce += 1 # Keep trying
      end
    end
  end

  def calculate_hash(nonce = 0)
    sha = Digest::SHA256.new
    sha.update(nonce.to_s + @index.to_s + @timestamp.to_s + @data.to_s + @previous_hash)
    sha.hexdigest
  end
end

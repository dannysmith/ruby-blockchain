require 'digest'

class Block
  attr_reader :index, :data, :previous_hash, :timestamp, :hash

  def initialize(index, data, previous_hash)
    @index = index
    @data = data
    @previous_hash = previous_hash
    @timestamp = Time.now
    @hash = calculate_hash
  end

  private

  def calculate_hash
    sha = Digest::SHA256.new
    sha.update(@index.to_s + @timestamp.to_s + @data + @previous_hash)
    sha.hexdigest
  end
end

class Blockchain

  def initialize(genisis_data: 'Big Bang')
    @blocks = []
    @blocks << Block.new(0, genisis_data, '0')
  end

  def add(data:)
    previous_block = @blocks.last
    @blocks << Block.new(previous_block.index + 1, data, previous_block.hash)
  end

  def print
    @blocks.each do |block|
      puts '---------------'
      puts "Index: #{block.index}"
      puts "TimeStamp: #{block.timestamp}"
      puts "Hash: #{block.hash}"
      puts "Data: #{block.data}"
    end
    puts '---------------'
  end
end

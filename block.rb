require 'digest'
require 'json'

class Block
  attr_reader :index, :data, :previous_hash, :timestamp, :hash

  def initialize(index, data, previous_hash)
    @index = index
    @data = data
    @previous_hash = previous_hash
    @timestamp = Time.now
    @hash = calculate_hash
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

  def to_array
    [].tap {|array| @blocks.each {|block| array << block.to_h } }
  end

  def to_json
    JSON.pretty_generate(self.to_array)
  end

  def save(filename='blockchain.json')
    File.open(filename,'w') { |f| f.write(self.to_json) }
  end

  # Class methods

  def self.load(path)
    blocks, chain = [], self.new
    JSON.parse(File.read(path), symbolize_names: true).each do |block_hash|
      blocks << Block.__create(block_hash)
    end
    chain.instance_variable_set(:@blocks, blocks)
    chain
  end
end

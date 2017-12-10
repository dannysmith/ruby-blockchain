# Ruby Implementation of a Blockchain

To run

```shell
bundle install
ruby app.rb
```

To use:

```ruby
bc = Blockchain.new(genisis_data: 'Genisis')
bc.add(data: 'First item of data')
bc.add(data: 'Second item of data')
bc.add(data: 'Third item of data')
bc.add(data: 'Fourth item of data')

bc.print
bc.to_array
bc.to_json
bc.save
```

Or to load an existing blockchain:

```ruby
require './block'
bc = Blockchain.load('./blockchain.json')

bc.print
```

To make some transactions and add them to a block:

```ruby
transactions = [
  Transaction.new(from: 'danny', to: 'ben',    payload: 'BTC', qty: 2),
  Transaction.new(from: 'bob',   to: 'danny',  payload: 'BTC', qty: 4),
  Transaction.new(from: 'andy',  to: 'katie',  payload: 'ABC', qty: 1),
  Transaction.new(from: 'katie', to: 'hannah', payload: 'BTC', qty: 1),
]

bc = Blockchain.new(genisis_data: 'Genisis')
bc.add data: transactions
bc.print
```

To use transactions and wallets together:

```ruby
w1 = Wallet.new(pass_phrase: 'secret1', name: 'danny')
w2 = Wallet.new(pass_phrase: 'secret2', name: 'ben')

transactions = [
  Transaction.new(from: w1.address, to: w2.address, payload: 'BTC', qty: 4),
  Transaction.new(from: w2.address, to: w1.address, payload: 'BTC', qty: 1)
]

bc = Blockchain.new(genisis_data: 'Genisis')
bc.add data: transactions
bc.print
bc.save('myblockchain.json')
exit # Quit, then...

# Load the stored bloackchain
bc = Blockchain.load('myblockchain.json')

# Regenerate the wallets
w1 = Wallet.new(pass_phrase: 'secret1', name: 'danny')
w2 = Wallet.new(pass_phrase: 'secret2', name: 'ben')

# Get the balance of a wallet
bc.get_balance(w1.address)
bc.get_balance(w2.address)
```

## TODO

- [X] Add Proof of Work
- [X] Abstract Block into seperate file
- [X] Add check balance method
- [X] Add wallet mechanism
- [ ] Refactor for brevity
- [ ] Transactions are currently represented as hashes when they're loaded from file. They should be turned into `Transaction` objects.
- [ ] Add mining stuff (verify a tx is valid (ie has enough in th wallet) before making a block)
- [ ] Add Unit Test for Transaction
- [ ] Add Unit Test for Wallet
- [ ] Add Unit Test for Block
- [ ] Add Unit Test for Blockchain
- [ ] Add Integration Test
- [ ] Add better pub/priv key generation to wallet

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

## TODO

- [ ] Refactor for brevity
- [X] Add Proof of Work
- [X] Abstract Block into seperate file
- [ ] Add Unit Test for Transaction
- [ ] Add Unit Test for Block
- [ ] Add Unit Test for Blockchain
- [ ] Add Integration Test

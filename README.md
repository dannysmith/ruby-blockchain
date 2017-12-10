# Ruby Implementation of a Blockchain

To use:

```ruby
require './block'
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

bc.print
```

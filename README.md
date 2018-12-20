The purpose of this app is to demonstrate unexpected behavior in Ruby's net/http library. Valid UTF-8 response bodies are encoded as ASCII-8BIT, which apparently means Ruby is treating them as pure binary data, even when Content-Type headers label the body as UTF-8.

In the example below, I would expect the response body to have UTF-8 encoding. Especially because when I copy and paste the body into a new string literal in my console, that string is UTF-8 encoded.

```ruby
require 'net/http'
uri = URI('https://utf8app.herokuapp.com')
uri.path = '/utf8/example'
res = Net::HTTP.get_response(uri)
res['Content-Type']
# => "text/plain; charset=utf-8"
puts res.body
# The symbol for the inch unit of measurement is ″.
res.body.encoding
# => #<Encoding:ASCII-8BIT>
res.body.ascii_only?
# => false
'The symbol for the inch unit of measurement is ″.'.encoding
# => #<Encoding:UTF-8>
```

We can demonstrate that the encoding issue is due to the non-ascii inches symbol by replacing it with a double quote instead.

```ruby
uri.path = '/ascii/example'
res = Net::HTTP.get_response(uri)
res['Content-Type']
# => "text/plain; charset=utf-8"
puts res.body
# The symbol for the inch unit of measurement is ".
res.body.encoding
# => #<Encoding:UTF-8>
res.body.ascii_only?
# => true
```

Finally, as an extra WTF, `JSON.parse` recognizes the non-ascii characters as valid UTF-8 in a JSON example.

```ruby
require 'json'
uri.path = '/utf8/example_json'
res = Net::HTTP.get_response(uri)
res['Content-Type']
# => "application/json; charset=utf-8"
puts res.body
# {"feet":"′","inches":"″"}
res.body.encoding
# => #<Encoding:ASCII-8BIT>
json = JSON.parse(res.body)
# => {"feet"=>"′", "inches"=>"″"}
json.values.map { |v| [v.encoding.to_s, v] }
# => [["UTF-8", "′"], ["UTF-8", "″"]]
```

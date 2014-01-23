![alt text](https://github.com/rrgayhart/apolloio/blob/staging/app/assets/images/logosmall.png?raw=true "Title")
-----------
The best API tracking app of all time.


## Setup

1. Install postgresql with: `brew install postgresql` or `apt-get install postgresql-9.2`
2. Copy `.ruby-version.example` to `.ruby-version` if you use a Ruby version manager such as RVM, rbenv or chruby
3. Install gems with: `bundle`
4. Get a client id/secret from Twitter at https://dev.twitter.com/apps/new
  * Name: whatever
  * URL: http://127.0.0.1:3000
  * Callback url: http://127.0.0.1:3000/twitter/callback
6. Presuming you have Postgres installed (if not: `brew install postgres`):
  * create database with: `rake db:setup` or `rake db:create`
7. Run the database migrations with `rake db:migrate db:test:prepare`.
8. Run the database seed with `rake db:seed`. **coming iteration**
11. Start the server with `rails s`
12. Login at http://localhost:3000.

## Testing

1. Prepare the test environment with `RACK_ENV=test rake db:migrate`.
2. Make sure that `postgres` is running.
3. Run the test suite with `rake test`.
4. Run individual tests with `ruby -I test test/models/api_request_test.rb`.
5. To add VCR to any test that uses an api call, please wrap any http call in a 
```ruby
VCR.use_cassette('use any name here') do
end
```

## Production Link

http://apollotheio.herokuapp.com/

## License

MIT License

Copyright (C) 2014 Quentin Tai, Jonah Moses, Adam Magan, Romeeka Gayhart
 
Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:
 
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

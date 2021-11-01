
===================

Ruby app

# Requirements

* Ruby 3.0.0
* Redis 4.0

# Getting Started

The following services need to be up and running.

```sh
  $ redis-server & (Runs redis as a backgroung process)
```

Run the following to run the methods.
`$ ruby app.rb`

# Questions

### 1. What would you do differently if you had more time?
I'd find a way to store this on a diferent set of json strings on redis because of string limitation.
### 2. What is the runtime complexity of each function?
`request_handled(ip_address)`: O(1)

`top100(limit = 100)`:  O(n log n)

`clear`: O(1)
### 3. How does your code work?
`request_handled(ip_address)` method receives the ip_address as a string, gets the string data from redis and parsed the content, sets the default value as zero which is going to be returned whenever a key does not exist in the hash and store the ip_address with a counter and sets the sting in redis as a json with the new information added.
`top100(limit = 100)` method gets the string data from redis and parsed the content. Then, sorts the hash desdendently, this returns an array, then pick the first 100 positions and then convert the array to hash again. The method can receive the limit as an argument, so instead of top 100, we can do top 5 or top 10.
`clear` method uses a redis method to remove the content from the redis.

### 4. What other approaches did you decide not to pursue?
Allocate every ip_address on a different key on redis instead of adding them on a json.

### 5. How would you test this?
I'd use RSpec franework to test this.

`request_handled(ip_address)` I'd test that the data is properly set on redis and two scenarios, if the key does not exist on the structure is stored with 0 count and if the key already exists in the structure and the counter is properly incremented.

`top100(limit = 100)` I'd setup some data to test, a json string with 10 elements, and I'd call the method with an argument 10 and test that the result is properly sorted and the structure is the expected.

`clear` I'd setup a json string with one element, and test that after calling the method the content is no longer persisted.
# LarvataCable
Chat functionality in a small Rails engine

## Usage
Read the specs, [ActionCable
docs](https://guides.rubyonrails.org/action_cable_overview.html), [AnyCable docs](https://docs.anycable.io).

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'larvata_cable'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install larvata_cable
```

## How to initiate a websocket connection with brute force

The GET request must contain the following headers:

| Header Key    | Header Value     |
|---------------|------------------|
| Authorization | Bearer {{token}} |
| Connection    | Upgrade          |
| Upgrade       | websocket        |
| Origin        | {{hostname}}     |

Note there is an empty space in the `Authorization` header between
`Bearer` and the actual authentication token.

The `Connection` and `Upgrade` headers are necessary to upgrade the HTTP
request to a websocket connection.

The `Origin` header is used to specify the request origin.

Here is an example of the raw request generated using Postman:

```
GET /cable HTTP/1.1
Host: localhost:3000
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1cGRhdGVkX2F0IjoiMjAxOS0wOC0xMyAwMzoyNzo0NSBVVEMifQ.-XbhQoFIsT53jvDUwrquPq3t3hhSyBan7zyqRyf4hT0
Connection: Upgrade
Upgrade: websocket
Origin: http://localhost:3000
Content-Type: application/json
User-Agent: PostmanRuntime/7.15.2
Accept: */*
Cache-Control: no-cache
Postman-Token: 8f38456a-4047-4ec9-ad0f-467fbdd1a0bd,593b43b9-a358-4e84-a664-94dea3a302d1
Host: localhost:3000
Accept-Encoding: gzip, deflate
Content-Length: 22
cache-control: no-cache

{
  "chat_room_id": 1
}
```

## Authentication Strategies

1) Check is user has been authenticated through Warden
2) Via `account` and `password` if given
3) Via Authorization header

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

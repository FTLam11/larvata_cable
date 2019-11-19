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

## Configuration

The host application is responsible for [configuring
ActionCable](https://guides.rubyonrails.org/action_cable_overview.html#configuration).

## Working with ActionCable

### Authentication Strategies

Requests should use the `Authorization` header for establishing
websocket connections. All other API requests should include a signed
token in the request body under the key `token`. See below links for
more information about payload signing.

* [ios](https://github.com/christophhagen/Curve25519)
* [android](https://github.com/signalapp/curve25519-java)

### Example Chat Workflow

1. Client authenticates with host application using credentials.
2. With valid user credentials, host application responds with session
   cookie.
3. Client accesses a chat resource on host application.
4. Host application uses LarvataCable public key to encrypt a JSON
   token string payload containing:

```javascript
{
  app_id: APPLICATION ID,
  data: {
    user_id: USER ID
  }
}
```

5. Host application attaches the authentication token to a `POST`
   request to the LarvataCable `/auth` endpoint.
6. LarvataCable decrypts token using its private key, verifies application
   ID, and responds with authorization JWT with the following format:

```javascript
// HEADER
{
  alg: "HS256",
  typ: "JWT"
}

// PAYLOAD
{
  sub: USER ID,
  exp: EXPIRATION TIME
}

// SIGNATURE
```

7. Client receives authorization JWT from host application and makes GET
   request to LarvataCable ActionCable `/cable` endpoint. The request
   must attach the JWT to the `Authorization` header.
8. LarvataCable server verifies Authorization JWT and upgrades HTTP
   connection to Websocket connection.
9. Client and LarvataCable use ActionCable API to send/receive messages.

## API Documentation

Latest and greatest API docs can be found
[here](https://documenter.getpostman.com/view/8670571/SVfTPTAt?version=latest).

## Use cases

1. Chat rooms/direct messaging
2. Broadcasting updates
3. Live comments section
4. Online/offline user status

## Appendix

### How to initiate a websocket connection with brute force

**You should definitely use a client-side ActionCable or websocket library.**

#### IOS

* [Swift-ActionCableClient](https://github.com/danielrhodes/Swift-ActionCableClient)
* [Starscream](https://github.com/daltoniam/Starscream)

#### Android

* [actioncable-client-java](https://github.com/hosopy/actioncable-client-java)
* [actioncable-client-kotlin](https://github.com/hosopy/actioncable-client-kotlin)

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
```

### Subscribing to a channel

Once the websocket connection is established, the client can subscribe
to a channel by sending a json message in the following format:

```javascript
{
  command: "subscribe",
  identifier: {
    channel: "ChatRoomChannel"
  }
}
```

The client will automatically stream messages from the subscribed
channel.

### Sending messages

Once a channel subscription is created, the client can send messages to
the channel. The example below shows the general message format. The
`command` and `identifier` keys are static, these are the default keys
used by ActionCable.

The `action` key in `data` must match a method implemented on the server
side's `ChatRoomChannel` channel. Depending on how the server channel is
implemented, there may be a need for another identifier to commmunicate
which chat room to send the message to. The example below assumes
`ChatRoomChannel` has many chat rooms. Finally `body` contains the
message content and can be changed to another key agreed upon by the
server and client.

```javascript
{
  command: "message",
  identifier: {
    channel: "ChatRoomChannel",
    chat_room_id: 322
  },
  data: {
    action: "chat",
    body: "Yo what up homie"
  }
}
```

### Unsubscribing from a channel

If the client wishes to disconnect from a channel, a message in the
following format should be sent to the server:

```javascript
{
  command: "unsubscribe",
  identifier: {
    channel: "ChatRoomChannel"
  }
}
```

The client in this case unsubscribes from the `ChatRoomChannel` and will
not receive messages from it.

## Potential API Workflows

1. Not possible to use session cookie because of different origin (for
   web clients). Mobile clients should be OK?
2. Use an opaque token: Might not be too bad since will have to query
   for a given user's chats and messages. What is the significance of
   device ID? Using the chat workflow, a permanent opaque token can be
   granted instead of a JWT.
3. JWT: Eww blacklisting and refresh tokens
4. Host application server proxies API calls to LarvataCable, sends
   application ID and params. (WINNER)

* API/websocket authorization is via server proxying
* Publish/subscribe is client direct to LarvataCable server

## Multitenant data modeling

Without persisting user data, database constraints are useless and
ActiveRecord associations cannot be used without hacks. Different host
applications may also have different modeling needs.

Given database constraints and ActiveRecord associations cannot be
compromised and a need to satisfy potentially vastly different modeling
needs, a potential solution is to only persist:

1. `user_id`: Host application user ID
2. `application_id`: Host application application ID
3. `data`: JSON type column containing arbitrary data sourced from host
   application

Must assume that LarvataCable does nothing with the host application
supplied `data`. The reasoning is this data cannot be relied upon to be
the source of truth, since the data originates from the host
application.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

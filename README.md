# hubot event script

Allows you to push events to hubot, allowing you to recall when that event happened.
You might find this useful for pushing build events or version information?

See [`src/event.coffee`](src/event.coffee) for full documentation.

## Installation

npm install hubot-event
add "hubot-event" to your external scripts.


```
@Hubot event set production release
@Hubot event me production
-> production:
   last release on 2 Thu Jun 04 2015 08:56:24 GMT+0100 (BST)
```

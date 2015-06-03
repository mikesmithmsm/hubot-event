# Description:
#   Rightscale huboter
#
# Commands:
#   hubot info set {key} {value} - the time to record the event
#   hubot info me {key} recall all events

class Information
  events: {}
  constructor: (@name) ->

  addEvent: (key, timestamp) ->
    this.events[key] = timestamp

  eventTime: (key) ->
    return this.events.get key

  print: () ->
    info = "#{this.name}:\n"
    for k,v of this.events
      info += "#{k} on #{v}\n"

    return info

information = {}


module.exports = (robot) ->
  robot.respond /(info set) (.*) (.*)/i, (msg) ->
    setInformation(msg.match[2], msg.match[3], msg)
  robot.respond /(info me) (.*)/i, (msg) ->
    getInformation(msg.match[2], msg)

getInformation = (key, msg) ->
  info = getInformationRecord(key)
  msg.send "#{info.print()}"

setInformation = (key, value, msg) ->
  info = getInformationRecord(key)
  info.addEvent value, new Date()

getInformationRecord = (key) ->
  if hasInformation key
    return information[key]

  newInformation = new Information(key)
  information[key] = newInformation
  return newInformation

hasInformation = (key) ->
  return information[key]

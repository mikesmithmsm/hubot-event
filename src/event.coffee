# Description:
#   Rightscale huboter
#
# Commands:
#   hubot event set {key} {value} - the time to record the event
#   hubot event me {key} recall all events

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
      info += "last #{k} on #{v}\n"

    return info

module.exports = (robot) ->
  robot.hear /(event set) (.*) (.*)/i, (msg) ->
    setInformation(msg.match[2], msg.match[3], msg, robot)
  robot.hear /(event force) (.*) (.*) (.*)/i, (msg) ->
    forceInformation(msg.match[2], msg.match[3], msg.match[4], msg, robot)
  robot.hear /(event clear) (.*)/i, (msg) ->
    clearInformation(msg.match[2], msg, robot)
  robot.respond /(event me) (.*)/i, (msg) ->
    getInformation(msg.match[2], msg, robot)

getInformation = (key, msg, robot) ->
  if hasNoInformationFor key, robot
    msg.send "Sorry there are no events recorded yet for #{key}"
  else
    info = getInformationRecord key, robot
    msg.send "#{info.print()}"

setInformation = (key, value, msg, robot) ->
  info = getInformationRecord(key, robot)
  info.addEvent value, new Date()

forceInformation = (key, time ,value, msg, robot) ->
  info = getInformationRecord(key, robot)
  info.addEvent value, Date.parse(time)

clearInformation = (key, msg, robot) ->
  robot.brain.remove("event.#{key}")
  msg.send "Events cleared for #{key}"

getInformationRecord = (key, robot) ->
  if hasInformationFor key, robot
    return robot.brain.get("event.#{key}")

  newInformation = new Information(key)
  robot.brain.set("event.#{key}", newInformation)
  return newInformation

hasNoInformationFor = (key, robot) ->
  return ! hasInformationFor key, robot

hasInformationFor = (key, robot) ->
  return robot.brain.get("event.#{key}") != null

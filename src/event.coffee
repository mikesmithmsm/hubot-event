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
      info += "#{k} on #{v}\n"

    return info

information = {}


module.exports = (robot) ->
  robot.respond /(event set) (.*) (.*)/i, (msg) ->
    setInformation(msg.match[2], msg.match[3], msg)
  robot.respond /(event me) (.*)/i, (msg) ->
    getInformation(msg.match[2], msg)

getInformation = (key, msg) ->
  if hasNoInformationFor key
    msg.send "Sorry there are no events recorded yet for #{key}"
  else
    info = getInformationRecord(key)
    msg.send "#{info.print()}"

setInformation = (key, value, msg) ->
  info = getInformationRecord(key)
  info.addEvent value, new Date()

getInformationRecord = (key) ->
  if hasInformationFor key
    return information[key]

  newInformation = new Information(key)
  information[key] = newInformation
  return newInformation

hasNoInformationFor = (key) ->
  return ! hasInformationFor key

hasInformationFor = (key) ->
  return information[key]

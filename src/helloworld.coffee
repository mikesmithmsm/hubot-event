# Description:
#   Rightscale huboter
#
# Commands:
#   hubot test me something - responds with Hello World and echos back any text

module.exports = (robot) ->
  robot.respond /(test me) (.*)/i, (msg) ->
    msg.send "Hello World #{msg.match[2]}"

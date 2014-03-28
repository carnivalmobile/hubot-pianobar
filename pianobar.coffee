# Description:
#  Control pianobar 
#
# Commands:
#  pianobar <command>
#  See the full list of commands here: http://manpages.ubuntu.com/manpages/maverick/man1/pianobar.1.html
#

fs = require('fs')
log = "/var/log/pianobar"

module.exports = (robot) ->
  robot.respond /pianobar\s+(.*)$/i, (msg) ->
    fs.appendFile HUBOT_PIANOBAR_COMMAND_FILE, msg.match[1] + "\n", (err) ->
      msg.send "I had a problem: " + msg.code if err

  fs.watchFile log, (prev, curr) ->
    fs.readFile log, "utf8", (err, body) ->
      robot.send HUBOT_PIANOBAR_TARGET_JABBER_ID, body

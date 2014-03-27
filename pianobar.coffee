# Description:
#  Control pianobar 
#
# Commands:
#  pianobar <command>
#  See the full list of commands here: http://manpages.ubuntu.com/manpages/maverick/man1/pianobar.1.html
#

fs = require('fs')
log = "/var/log/pianobar" 
command = fs.createWriteStream('~/.config/pianobar/ctl', {'flags': 'a'})

module.exports = (robot) ->
  robot.respond /pianobar\s*(.*)?$/i, (msg) ->
    command.write msg.match[1] + '\n'

  fs.watchFile log, (prev, curr) ->
    fs.readFile log, "utf8", (err, body) ->
      robot.send HUBOT_PIANOBAR_TARGET_JABBER_ID, body 

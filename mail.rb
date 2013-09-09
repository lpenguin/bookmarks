require 'mail'

def parse_message(message)
    #puts message
    mail = Mail.new(message)
    puts mail ['from']
#  do_other_stuff!
end

message = nil

file = File.open('/var/mail/lpenguin')

while (line = file.gets)
  if (line.match(/\AFrom /))
    parse_message(message) if (message)
    message = ''
  else
    message << line.sub(/^\>From/, 'From')
  end
end

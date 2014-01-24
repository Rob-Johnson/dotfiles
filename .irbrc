require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

# 25 entries in the list
IRB.conf[:SAVE_HISTORY] = 1000

# Save in ~
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

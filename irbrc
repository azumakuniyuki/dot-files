# ~/.irbrc

require 'rubygems'
require 'readline'
require 'wirble'

IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 512
IRB.conf[:AUTO_INDENT] = true

Wirble.init

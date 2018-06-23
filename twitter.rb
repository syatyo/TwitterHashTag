#
#  twitter.rb
#  TwitterHashTag
#
#  Created by syatyo on 2018/06/23.
#  Copyright © 2018年 syatyo All rights reserved.

require "bundler"
Bundler.require
require "twitter"
require "./secret"

# do
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end

limit = 10

tag = "エンジニア生存戦略"

client.search("##{tag}", lang: "ja", result_type: "recent", count: 1).take(limit).map do |tweet|
  puts "#{tweet.user.name}: #{tweet.text}"
end

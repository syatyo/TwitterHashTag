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

tag = "エンジニア生存戦略"

# count: 1ページに返すtweetの数。最大100件まで。
# take: 取得件数。なので最大100件取得が10回回る？
# iのインクリメント検証では678回回った。
 i = 0
client.search("##{tag}", lang: "ja", result_type: "recent", count: 100).take(1000).map do |tweet|
  i += 1
  puts "#{i}件目のツイート"

  if tweet.user.id != MY_TWITTER_ID then
    follow = client.follow(tweet.user.id)
    begin
      puts "#Followed #{tweet.user.id}"
      puts "#{follow}"
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end

end

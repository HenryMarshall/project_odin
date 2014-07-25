require 'jumpstart_auth'
require 'klout'
require 'bitly'

class MicroBlogger

  attr_reader

  def initialize
    puts "Initializing"
    @client = JumpstartAuth.twitter

    Bitly.use_api_version_3
    @bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')

    Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
  end

  def run
    puts "Welcome to my twitter client"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp.split
      case input[0]
      when 'q' then puts "Goodbye!"; exit
      when 't' then tweet input[1..-1].join(" ")
      when 'turl' then tweet "#{input[1..-2].join(" ")} #{shorten input[-1]})"
      when 's' then shorten input[1]
      when 'dm' then direct_message input[1], input[2..-1]
      when 'spam' then spam_my_followers input[1..-1].join(" ")
      when 'latest' then everyones_latest_tweet
      else
        puts "Sorry, I don't know how to #{input}"
      end
    end
  end

  def klout_score
    @client.friends.each do |friend|
      identity = Klout::Identity.find_by_screen_name(friend.screen_name)
      user = Klout::User.new(identity.id)
      score = user.score.score
      puts "#{friend.screen_name}: #{score}\n\n"
      score
    end
  end

  private 

  def shorten url
    @bitly.shorten(url).short_url
  end

  def tweet message
    if message.length > 140
      puts "too long"
    else
      @client.update(message)
    end
  end

  def direct_message target, message
    puts "Trying to send #{target} this direct message: #{message}"
    if followers_list.include? target
      message = "d #{target} #{message}"
      tweet message
      puts "Message sent!"
    else
      puts "That user isn't following you!"
    end
  end

  def spam_my_followers message
    followers_list.each do |follower|
      direct_message follower, message
    end
  end

  def everyones_latest_tweet
    sorted_friends = @client.friends.sort_by do |friend|
      friend.screen_name.downcase
    end
    sorted_friends.each do |friend|
      tweet = friend.status
      timestamp = tweet.created_at.strftime("%A, %b %d")
      puts "#{friend.screen_name} said this on #{timestamp}..."
      puts "#{tweet.text}\n\n"
    end
  end    

  def followers_list
    @client.followers.map { |user| user.screen_name }
  end
end


blogger = MicroBlogger.new
blogger.klout_score
blogger.run
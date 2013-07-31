class User < ActiveRecord::Base
	has_many :tweets
  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_in(30.seconds.from_now, tweet.id) 
  end
end

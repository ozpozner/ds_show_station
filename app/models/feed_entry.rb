#require 'simple-rss'
class FeedEntry < ActiveRecord::Base
def self.update_from_feed(feed_url)
  # feed = Feedzirra::Feed.fetch_and_parse(feed_url)
  feed = SimpleRSS.parse open(feed_url)
  feed.entries.each do |entry|
    unless exists?(:name => entry.title.to_s.force_encoding('UTF-8') , :channel => feed.channel.link.to_s.force_encoding('UTF-8'))
      create!(
        :name         => entry.title.to_s.force_encoding('UTF-8'),
        :summary      => entry.description.to_s.force_encoding('UTF-8'),
        :url          => entry.link.to_s.force_encoding('UTF-8'),
        :published_at => entry.pubDate,
        :guid         => entry.guid.to_s.force_encoding('UTF-8'),
		:channel      => feed.channel.link.to_s.force_encoding('UTF-8')
      )
    end
  end
end

def self.update_urls
   FeedEntry.update_from_feed("http://aristeguinoticias.com/category/mexico/feed/")
   FeedEntry.update_from_feed("http://www.mexiconewsnetwork.com/es/rss/noticias/")
 end

end
# feed = SimpleRSS.parse open("http://www.mexiconewsnetwork.com/es/rss/noticias/")
# entry = feed.entries.first
# FeedEntry.exists?(:name => entry.title.to_s , :channel => feed.channel.link.to_s)
# FeedEntry.update_urls
#ilan.leizgold@bynet.co.il

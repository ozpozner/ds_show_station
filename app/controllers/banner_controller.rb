class BannerController < ApplicationController
   layout false
  def rss
  end
  
  def refresh
    FeedEntry.update_urls
    render layout: false
  end
  
end

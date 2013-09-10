class VideoController < ApplicationController
  def index
    page 'videos'
    @videos = A2::VimeoFeed.order('date desc').limit(8)
  end
end

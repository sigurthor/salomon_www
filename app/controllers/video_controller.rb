class VideoController < ApplicationController
  def index
    page 'videos'
    @videos = A2::VimeoFeed.all
  end
end

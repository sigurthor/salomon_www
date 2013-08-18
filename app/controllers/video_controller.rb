class VideoController < ApplicationController
  def index
    @videos = A2::VimeoFeed.all
  end
end

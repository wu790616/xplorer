class TopicsController < ApplicationController

  def index
    @hot_topics = Topic.all.order(followers_count: :desc).limit(5)
  end

end

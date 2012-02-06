class CommentsController < ApplicationController
  #before_filter :authenticate!
  require 'pp'
  def create
    type = params["comment_text"]
    pp type.size
  end
end

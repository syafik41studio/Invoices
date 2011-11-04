class PostCategoriesController < ApplicationController

  before_filter :authenticate_user!

  def new
    @post_category = PostCategory.new
    respond_to do |format|
      format.html{}
      format.js
    end
  end

  def create
    @post_category = PostCategory.new(params[:post_category])
    @post_category.save
    @categories = current_user.post_categories
    @post = Post.new
  end

end

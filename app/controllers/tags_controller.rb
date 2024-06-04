class TagsController < ApplicationController
    def index
        @tags = Tag.find(params[:id])
        @posts = @tags.posts(posts.id)
    end 
end

require 'spec_helper'

describe TumblrWrapper::BlogResource do
  let(:token) { mock(:token) }
  subject(:blog_resource) { TumblrWrapper::BlogResource.new('myblog.tumblr.com') }

  describe "blog" do
    it "returns a new blog with the hostname and access token" do
      blog = blog_resource.blog
      blog.class.should == TumblrWrapper::Blog

      blog.access_token.should == blog_resource.access_token
      blog.hostname.should == blog_resource.hostname
    end
  end

  describe "post" do
    it "returns a new post with the hostname and access token" do
      post = blog_resource.post
      post.class.should == TumblrWrapper::Post

      post.access_token.should == blog_resource.access_token
      post.hostname.should == blog_resource.hostname
    end
  end
end

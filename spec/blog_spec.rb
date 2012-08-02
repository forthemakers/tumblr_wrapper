require 'spec_helper'

describe TumblrWrapper::Blog do
  let(:token) { mock(:token) }
  subject(:blog) { TumblrWrapper::Blog.new('myblog.tumblr.com') }

  it "is a blog resource" do
    TumblrWrapper::Blog.superclass.should == TumblrWrapper::BlogResource
  end

  describe '.info' do
    it "makes an api request" do
      blog.should_receive(:http_get).with('info')

      blog.info
    end
  end

  describe "followers" do
    it "makes an oauth request" do
      blog.should_receive(:http_get).with('followers', {signed: true}, {})

      blog.followers
    end

    it "accepts parameters" do
      blog.should_receive(:http_get).with('followers', {signed: true}, { limit: 20, offset: 5 })

      blog.followers({ limit: 20, offset: 5 })
    end
  end

  describe "posts" do
    it "makes an api request" do
      blog.should_receive(:http_get).with('posts/', {signed: false}, {})

      blog.posts
    end

    it "accepts type parameter" do
      blog.should_receive(:http_get).with('posts/', {signed: false}, type: 'text')

      blog.posts(type: 'text')
    end
  end
end

require 'spec_helper'

describe TumblrWrapper, type: :integration do
  before do
    TumblrWrapper.consumer_key = consumer_key
    TumblrWrapper.consumer_secret = consumer_secret
  end

  it "can get an authorize url" do
    VCR.use_cassette('authorize_url') do
      client = TumblrWrapper::Client.new
      client.authorize_url.should =~ /http\:\/\/www\.tumblr\.com\/oauth\/authorize\?oauth_token/
    end
  end

  context "given a valid verifier and request token" do
    it "can get an access token" do
      VCR.use_cassette('access_token') do
        client = TumblrWrapper::Client.new
        client.build_request_token(request_token, request_secret)

        token = client.request_access_token(oauth_verifier)
      end
    end
  end

  context "given an access token" do
    describe "blog" do
      it "can request blog info" do
        VCR.use_cassette('blog_info') do
          client = TumblrWrapper::Client.new
          token = client.build_access_token(access_token, access_token_secret)

          blog_resource = TumblrWrapper::Blog.new(blogname, token)
          info = blog_resource.info

          info.body["meta"]["status"].should == 200
          info.body["response"]["blog"]["title"].should == blog_title
        end
      end

      it "can request followers" do
        VCR.use_cassette('blog_followers') do
          client = TumblrWrapper::Client.new
          token = client.build_access_token(access_token, access_token_secret)

          blog_resource = TumblrWrapper::Blog.new(blogname, token)
          followers = blog_resource.followers
        end
      end

      it "can request posts" do
        VCR.use_cassette('blog_posts') do
          client = TumblrWrapper::Client.new
          token = client.build_access_token(access_token, access_token_secret)

          blog_resource = TumblrWrapper::Blog.new(blogname, token)
          posts = blog_resource.posts
        end
      end
    end

    describe "post" do
      it "can create a post" do
        VCR.use_cassette('post_create') do
          client = TumblrWrapper::Client.new
          token = client.build_access_token(access_token, access_token_secret)

          post = TumblrWrapper::Post.new(blogname, token)
          post = post.create({
            type: 'text',
            body: "<p>hello world</p>"
          })
        end
      end

      xit "can delete a post" do
      end

      xit "can update a post" do
      end
    end
  end
end

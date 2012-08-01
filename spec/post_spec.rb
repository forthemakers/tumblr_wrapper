require 'spec_helper'

describe TumblrWrapper::Post do
  let(:token) { mock(:token) }
  subject(:post) { TumblrWrapper::Post.new('myblog.tumblr.com') }

  it "is a blog resource" do
    TumblrWrapper::Post.superclass.should == TumblrWrapper::BlogResource
  end

  describe "create" do
    it "makes an oauth request with parameters" do
      post.should_receive(:oauth_request).with('post', :post, {:type => 'text'})

      post.create({:type => 'text'})
    end

    it "raises unless type is specified" do
      lambda do
        post.create
      end.should raise_error(TumblrWrapper::MissingRequiredParameter)
    end

    it "raises if id is sent" do
      lambda do
        post.create({type: 'text', id: '1234'})
      end.should raise_error(TumblrWrapper::InvalidParameter)
    end
  end

  describe "update" do
    it "makes an oauth request with parameters" do
      post.should_receive(:oauth_request).with('post/edit', :post, {:id => '1234'})

      post.update({:id => '1234'})
    end

    it "raises unless id is specified" do
      lambda do
        post.update
      end.should raise_error(TumblrWrapper::MissingRequiredParameter)
    end
  end

  describe "delete" do
    it "makes an oauth request with parameters" do
      post.should_receive(:oauth_request).with('post/delete', :post, {:id => '1234'})

      post.delete({:id => '1234'})
    end

    it "raises unless id is specified" do
      lambda do
        post.delete
      end.should raise_error(TumblrWrapper::MissingRequiredParameter)
    end
  end
end

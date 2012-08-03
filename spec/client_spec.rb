require 'spec_helper'

describe TumblrWrapper::Client do
  let(:token) { mock(:token) }
  subject(:client) { TumblrWrapper::Client.new }
  before do
    TumblrWrapper.consumer_key = "consumer key"
    TumblrWrapper.consumer_secret = "consumer secret"
  end

  describe "request_access_token" do
    let(:access_token) { mock }
    let(:request_token) { mock }

    it "gets from oauth and sets access_token" do
      client.should_receive(:request_token).and_return(request_token)
      request_token
        .should_receive(:get_access_token)
        .with(oauth_verifier: 'verifier')
        .and_return(access_token)

      access_token.should_receive(:token).and_return('token')
      access_token.should_receive(:secret).and_return('secret')

      token_hash = client.request_access_token('verifier')

      token_hash[:token].should == 'token'
      token_hash[:token_secret].should == 'secret'
      token_hash[:consumer_key].should == 'consumer key'
      token_hash[:consumer_secret].should == 'consumer secret'
    end
  end
end

# TumblrWrapper

This is a basic wrapper for the tumblr api written in ruby. It requires Oauth and RestClient.
I haven't wrapped the response objects yet.

## Installation

Add this line to your application's Gemfile:

    gem 'tumblr_wrapper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tumblr_wrapper

## Usage

Set up:

    TumblrWrapper.consumer_key = "YOUR APPLICATION KEY"
    TumberWrapper.consumer_secret = "YOUR APPLICATION SECRET"

If you need the token and secret for a user:

    client = TumblrWrapper::Client.new

then authorize in browser here:

    client.authorize_url

    request_token = client.request_token.token
    request_token_secret = client.request_token.secret

tumblr oauth is strict, you need the oauth verifier from the response to get the access token:

    client.build_request_token(request_token, request_token_secret)
    access_token = client.request_access_token("OAUTH VERIFIER")

If you have the token and secret for your user:

    access_token = client.build_access_token("TOKEN", "SECRET")

The access token is memoized in either case, so you can call it again once it was set:

    access_token = client.access_token
    => {
          consumer_key: "YOUR APPLICATION KEY",
          consumer_secret: "YOUR APPLICATION SECRET",
          oauth_token: 'TOKEN',
          oauth_secret: 'SECRET',
        }

To get the first 40 posts of your blog:

    blog_resource = TumblrWrapper::BlogResource.new('yourblog.tumblr.com', access_token)

    blog = blog_resource.blow
    blog.posts(limit: 40)

or with pagination:

    blog.posts(limit: 20, offset: 0)
    blog.posts(limit: 20, offset: 20)

To post:

    blog_resource.post.create({ type: 'text', body: "Hello world." })

To update a post:

    post.update({id: "ID FROM TUMBLR", body: "Goodbye world."})

To delete a post:

    post.delete({id: "ID FROM TUMBLR"})

The response object is a TumblrWrapper::Response.
It responds to `:status`, `:message`, and any of the keys under "response" from tumblr.
Any of the values which are hashes will have indifferent access.
For example,

    response = blog.posts
    response.status.should == 200
    response.message.should == "OK"
    response.blog[:title].should == "Your Blog Title"
    response.posts.should be_a(Array)

Additional:
The date format tumblr expects when you are scheduling a post or updating the date the post was created is a lambda defined here:

    TumblrWrapper.date_format

In Rails 3, for example, you may want to set it up in an initializer:

    Time::DATE_FORMATS[:tumblr] = TumblrWrapper.date_format

    Time.now.to_s(:tumblr)
    => "2012-08-10 19:12:32 GMT"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

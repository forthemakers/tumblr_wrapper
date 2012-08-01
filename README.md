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

tumblr oauth is strict, you need to save the oauth verifier from the response:

    client.request_token(request_token, request_token_secret) // set the request token again
    access_token = client.access_token("OAUTH VERIFIER")

If you have the token and secret for your user:

    access_token = client.access_token_from_token_and_secret("TOKEN", "SECRET")

The access token is memoized in either case, so you can call it again once it was set:

    access_token = client.access_token

To get the first 40 posts of your blog:

    blog_resource = TumblrWrapper::BlogResource.new('yourblog.tumblr.com', access_token)

    blog_resource.blog.posts(limit: 40)

or with pagination:

    blog_resource.blog.posts(limit: 20, offset: 0)
    blog_resource.blog.posts(limit: 20, offset: 20)

To post:

    blog_resource.post.create({ type: 'text', body: "Hello world." })

To delete a post:

    blog_resource.post.delete({id: "ID FROM TUMBLR"})

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

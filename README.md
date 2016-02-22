# Alidayu::Ruby

阿里大鱼发送短信ruby sdk

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alidayu-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alidayu-ruby

## Usage

```ruby
# 配置 appkey 和 appsecret
# 如果使用rails 可以放到 config/alidayu.rb

Alidayu.appkey = ""
Alidayu.appsecret = ""

# 发短信
# 必须参数
# template_id       模版ID  String
# params            模版参数 Hash
# phones            电话号码 String or String[]
# sign_name         签名

# 具体文档 http://open.taobao.com/doc2/apiDetail?apiId=25450

Alidayu.send_sms({
  template_id: "SMS_0000000",
  sign_name: "身份验证",
  params: {
    code: '',
    product: '',
  },
  phones: "填写电话号码"
})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/davidqhr/alidayu-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
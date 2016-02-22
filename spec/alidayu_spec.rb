require 'spec_helper'

describe Alidayu do
  it 'can send message' do
    Alidayu.appkey = ""
    Alidayu.appsecret = ""

    Alidayu.send_sms({
      template_id: "SMS_0000000",
      sign_name: "身份验证",
      params: {
        code: '',
        product: '',
      },
      phones: "填写电话号码"
    })
  end
end

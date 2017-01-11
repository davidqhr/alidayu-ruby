require 'spec_helper'

describe Alidayu do
  before do
    Alidayu.appkey = ""
    Alidayu.appsecret = ""
  end

  it 'can send message' do
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

  it 'can send voice' do
    Alidayu.send_voice({
      template_id: "SMS_0000000",
      params: {
        code: '',
        name: ''
      },
      phone: "填写电话号码",
      show_phone: "填写显示的电话号码"
    })
  end
end

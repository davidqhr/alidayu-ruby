require "alidayu/version"
require 'json'
require 'net/https'
require 'uri'

module Alidayu
  class << self
    attr_accessor :appkey, :appsecret

    # 必须参数
    # template_id       模版ID  String
    # params            模版参数 Hash
    # phones            电话号码 String or String[]
    # sign_name         签名
    def send_sms params
      params = build_params(params)
      request(uri, params)
    end

    # 必须参数
    # template_id       模版ID  String
    # params            模版参数 Hash
    # phone             电话号码 String
    # show_phone        显示的电话号码 String
    def send_voice params
      params = build_voice_params(params)
      request(uri, params)
    end

    def uri
      @uri ||= URI.parse('https://eco.taobao.com/router/rest')
    end

    private

    def request(uri, params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(uri.path)
      request.add_field('Content-Type', 'application/json')
      request.set_form_data(params)
      response = http.request(request)
      res_body = JSON.parse response.body
      res_body
    end

    def build_params params
      alidayu_params = {
        :method => 'alibaba.aliqin.fc.sms.num.send',
        :app_key => appkey,
        :timestamp => Time.new.strftime("%Y-%m-%d %T"),
        :format => 'json',
        :v => '2.0',
        :sign_method => 'md5',
        :sms_type => 'normal',
      }

      # 电话号码
      if params[:phones].is_a? String
        alidayu_params[:rec_num] = params[:phones]
      elsif params[:phones].is_a? Array
        alidayu_params[:rec_num] = params[:phones].join(',')
      else
        raise 'phones格式错误'
      end

      # 模版ID
      alidayu_params[:sms_template_code] = params[:template_id]

      # 模版参数
      alidayu_params[:sms_param] = JSON(params[:params])

      # 签名
      alidayu_params[:sms_free_sign_name] = params[:sign_name] || sign_name

      sign = sign alidayu_params
      alidayu_params.merge!({:sign => sign})
      alidayu_params
    end

    def build_voice_params params
      alidayu_params = {
        :method => 'alibaba.aliqin.fc.tts.num.singlecall',
        :app_key => appkey,
        :timestamp => Time.new.strftime("%Y-%m-%d %T"),
        :format => 'json',
        :v => '2.0',
        :sign_method => 'md5',
        :sms_type => 'normal',
      }

      # 拨叫电话号码
      alidayu_params[:called_num] = params[:phone]

      # 拨叫显示号码
      alidayu_params[:called_show_num] = params[:show_phone]

      # 模版ID
      alidayu_params[:tts_code] = params[:template_id]

      # 模版参数
      alidayu_params[:tts_param] = JSON(params[:params])

      alidayu_params[:extend] = params[:extend] if params[:extend]

      sign = sign alidayu_params
      alidayu_params.merge!({:sign => sign})
      alidayu_params
    end

    def sign params
      joind_string = params.sort_by{ |k,v| k}.to_h.map { |k, v| "#{k}#{v}" }.join('')
      Digest::MD5.hexdigest("#{appsecret}#{joind_string}#{appsecret}").upcase
    end
  end
end
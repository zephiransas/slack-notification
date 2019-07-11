require 'logger'
require 'slack/incoming/webhooks'

module Slack
  class Webhook
    def initialize(url:, channel: 'random', username: nil)
      @logger = Logger.new(STDOUT)
      return if url.nil?

      @slack = Slack::Incoming::Webhooks.new(url, username: username)
      @slack.channel = channel
    end

    def post(message)
      @logger.info message
      unless @slack
        @logger.error 'Slack連携が未設定です'
        return
      end
      @slack.post("<!here> #{message}")
    end
  end
end

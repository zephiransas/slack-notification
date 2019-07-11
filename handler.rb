require 'json'
require './slack.rb'


def hello(event:, context:)
  url = ENV['WEBHOOK_URL']
  channel = ENV['CHANNEL']
  username = ENV['USERNAME']
  slack = Slack::Webhook.new(url: url, username: username, channel: channel)

  message = JSON.parse(event['Records'][0]['Sns']['Message'])
  job_id = message['detail']['jobId']
  reason = message['detail']['container']['reason']
  slack.post "ジョブが失敗しました\njob id:#{job_id}\nreason:#{reason}"

  { statusCode: 200, body: 'OK' }
end

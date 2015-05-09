require 'google/api_client'
$youtube = YouTube.new(Rails.application.secrets.youtube_dev_key, 'music', 25)
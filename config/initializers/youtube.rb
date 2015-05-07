require 'google/api_client'
$youtube = Youtube.new(Rails.application.secrets.youtube_dev_key, 'music', 25)
json.array!(@feeds) do |feed|
  json.extract! feed, :id, :info
  json.url feed_url(feed, format: :json)
end

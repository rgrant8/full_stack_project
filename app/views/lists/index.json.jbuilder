json.array!(@lists) do |list|
  json.extract! list, :id, :symbol, :name, :market, :country, :ipo, :sector, :alive
  json.url list_url(list, format: :json)
end

json.array!(@amexes) do |amex|
  json.extract! amex, :id, :symbol, :name, :market, :country, :ipo, :sector, :alive, :list_type
  json.url amex_url(amex, format: :json)
end

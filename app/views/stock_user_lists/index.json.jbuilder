json.array!(@stock_user_lists) do |stock_user_list|
  json.extract! stock_user_list, :id, :lists_id, :users_id
  json.url stock_user_list_url(stock_user_list, format: :json)
end

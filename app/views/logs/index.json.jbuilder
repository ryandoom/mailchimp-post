json.array!(@logs) do |log|
  json.extract! log, :id, :post_type, :params
  json.url log_url(log, format: :json)
end

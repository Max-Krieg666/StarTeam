json.array!(@transfers) do |transfer|
  json.extract! transfer, :id, :player_id, :vendor_id, :purchaser_id, :cost, :status
  json.url transfer_url(transfer, format: :json)
end

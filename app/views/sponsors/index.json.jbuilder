json.array!(@sponsors) do |sponsor|
  json.extract! sponsor, :id, :title, :specialization, :sponsorship, :loyalty_factor, :cost_of_full_stake, :win_prize, :draw_prize, :lost_prize
  json.url sponsor_url(sponsor, format: :json)
end

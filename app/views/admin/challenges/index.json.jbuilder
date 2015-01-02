json.array!(@challenges) do |challenge|
  json.extract! challenge, :id, :title, :start_at, :end_at, :description
  json.url challenge_url(challenge, format: :json)
end

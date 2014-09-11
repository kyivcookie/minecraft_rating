json.array!(@payments) do |payment|
  json.extract! payment, :id, :server_id, :user_id, :amount, :quantity, :payer_email, :description
  json.url payment_url(payment, format: :json)
end

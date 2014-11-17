json.array!(@admin_payments) do |admin_payment|
  json.extract! admin_payment, :id
  json.url admin_payment_url(admin_payment, format: :json)
end

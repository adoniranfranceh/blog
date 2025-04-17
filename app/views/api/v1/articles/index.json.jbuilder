# json.message 'batata'

json.data @articles do |article|
  json.partial! article
end

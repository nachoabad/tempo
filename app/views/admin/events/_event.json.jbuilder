json.extract! event, :id, :datetime, :note, :service_id, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)

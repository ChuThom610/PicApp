json.extract! album, :id, :name, :description, :user_id, :created_at, :updated_at
json.url album_url(album, format: :json)

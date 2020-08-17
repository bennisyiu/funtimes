json.extract! @user, :id, :open_id, :name, :avatar
json.created_at @user.created_at.strftime("%e %b %Y %H:%M:%S%p")

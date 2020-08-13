json.extract! @evint, :id, :title, :evint_link, :venue, :address, :lng, :lat, :category, :time, :description, :image_link, :date, :period, :wechatid
json.created_at @evint.created_at.strftime("%e %b %Y %H:%M:%S%p")

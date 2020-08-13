json.extract! @evint, :id, :title, :evint_link, :venue, :venue_link, :category, :date, :period, :time, :description, :image_link, :wechatid,  :address, :lng, :lat
json.created_at @evint.created_at.strftime("%e %b %Y %H:%M:%S%p")

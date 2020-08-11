json.extract! @evint, :id, :title, :evint_link, :venue, :address, :category, :time, :description, :image_link, :date, :wechatid
json.created_at @evint.created_at.strftime("%e %b %Y %H:%M:%S%p")

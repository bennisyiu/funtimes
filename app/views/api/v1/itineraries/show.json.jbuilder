json.extract! @itinerary, :id, :name, :date

json.created_at @itinerary.created_at.strftime("%e %b %Y %H:%M:%S%p")

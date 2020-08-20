json.array! @itineraries do |itinerary|
  json.extract! itinerary, :id, :name, :date
  json.guests itinerary.users do |user|
    json.extract! user, :id, :name, :avatar
  end
  json.activities itinerary.activities do |activity|
    json.activity_id activity.id
    json.evint_id activity.evint.id
    json.title activity.evint.title
    json.date activity.evint.date
    json.time activity.evint.time
    json.venue activity.evint.venue
    json.category activity.evint.category
    json.image activity.evint.image_link
    json.address activity.evint.address
    json.lng activity.evint.lng
    json.lat activity.evint.lat
  end
  json.created_at itinerary.created_at.strftime("%e %b %Y %H:%M:%S%p")
end

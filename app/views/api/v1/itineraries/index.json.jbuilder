json.array! @itineraries do |itinerary|
  json.extract! itinerary, :id, :name, :date #, :evint_id1, :evint_id2, :evint_id3
  # json.comments @message.comments, :content, :created_at
  json.activities itinerary.activities do |activity|
    json.title activity.evint.title
    json.date activity.evint.date
    json.time activity.evint.time
    json.venue activity.evint.venue
    json.category activity.evint.category
    json.image activity.evint.image_link
  end

  json.created_at itinerary.created_at.strftime("%e %b %Y %H:%M:%S%p")
end

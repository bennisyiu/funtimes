if @results.blank?
  []
else
  json.evints @results do |evint| # one result = one evint
    json.id evint.id
    json.title evint.title
    json.image evint.image_link
    json.venue evint.venue
    json.category evint.category
    json.date evint.date
    json.period evint.period
    json.time evint.time
    json.description evint.description
    json.wechatid evint.wechatid
    json.address evint.address
    json.lng evint.lng
    json.lat evint.lat
  end
end


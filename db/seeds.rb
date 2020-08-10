# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'
require 'byebug'

def scrape_event_details(event_link)
  url2 = event_link
  raw = open(url2).read
  parsed = Nokogiri::HTML(raw)
  details = {}
  card = parsed.css('div.xinxi')
    details[:address] = card.css('ul').css('li div.wenzi')[0].text.split(' ').join(' ')
    details[:phone] = card.css('ul').css('li div.wenzi')[2].text.strip
    details[:wechatid] = card.css('ul').css('li div.wenzi')[3].text.strip
    details[:area] = card.css('ul').css('li div.wenzi')[4].text.strip
    details[:time] = card.css('ul').css('li div.wenzi')[6].text.strip ## implement change hours method
  return details
end

def create_seeds
  url = "https://www.smartshanghai.com/events/?view=list&view=list"
  unparsed_page = open(url).read
  parsed_page = Nokogiri::HTML(unparsed_page)
  evint = {}
  parsed_page.search('.box').each  do |box|
    box.search('.events.listings li').each do |li|
      evint[:title] = li.css('h3 a').text.strip
      evint[:evint_link] = li.css('div.img a').attribute('href').value
      evint[:image_link] = "https://www.smartshanghai.com" + li.css('img').attribute('src').value
      evint[:description] = li.css('div.wenzi').text.strip
      evint[:category] = li.css('span.category').text.strip
      evint[:venue] = li.css('ul.riqi li a').text.strip
      evint[:date] = li.css('ul.riqi li').text.split.last ## implement change date method
      venue_details = li.css('ul.riqi li a').attribute('href').value
      details = scrape_event_details(venue_details) ## calling 2nd method here
      evint[:address] = details[:address]
      evint[:phone] = details[:phone]
      evint[:wechatid] = details[:wechatid]
      evint[:area] = details[:area]
      evint[:time] = details[:time]
      Evint.create!(evint)
      puts "Event: #{evint[:title]} created!"
    end
  end
end


create_seeds

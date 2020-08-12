# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'
# require 'byebug'
require 'date'

Evint.destroy_all

def change_date_format(str)
  if str == 'Today'
    date = Date.today.to_s
  else
    date = str
  end
end

def scrape_event_details(event_link)
  url2 = event_link
  raw = open(url2).read
  parsed = Nokogiri::HTML(raw)
  details = {}
  card = parsed.css('div.box')
  details[:address] = card.css('div.fast-navigation').css('div.dizhi span').first.text.split(' ').join(' ')
  details[:description] = card.css('div.xinxi').css('div.wenzi p').text.strip
  card.css('div.xinxi').css('ul.biaoqian li').each do |item|
    if item.css('span').text.downcase.include?("time")
      details[:time] = item.text.split().join.gsub('TIME:','')
    elsif item.css('span').text.downcase.include?("date")
      details[:time] = item.text.split().join.gsub('DATE:','')
    elsif item.css('span').text.downcase.include?("wechat")
      details[:wechatid] = item.text.split().last
    end
  end
  if !card.css('#pane-map').css('#locsel-lng').present?
    details[:lng] = 31.2304 # longtitude of Shanghai
    details[:lat] = 121.4737 #latitude of Shanghai
  elsif card.css('#pane-map').present?
    map = card.css('#pane-map')
    details[:lng] = map.css('#locsel-lng').attribute('value').to_s.to_f
    details[:lat] = map.css('#locsel-lat').attribute('value').to_s.to_f
  else
    details[:lng] = 31.2304 # longtitude of Shanghai
    details[:lat] = 121.4737 #latitude of Shanghai
  end
return details
end

 def create_seeds
  num = 0
  until num >= 30
    date = (Time.now + num.days)
    day = (Time.now + num.days).strftime("%Y-%m-%d")
    url = "https://www.smartshanghai.com/events/?day=#{day}&view=list"
    unparsed_page = open(url).read
    parsed_page = Nokogiri::HTML(unparsed_page)
    evints = []
    box = parsed_page.search('.box')[0]
    if box.search('.day').text.strip.to_i != 0
      box.search('li').each do |li|
        evint = {}
        if !li.css('h3').empty?
          evint[:title] = li.css('h3').text.strip
          evint[:evint_link] = li.css('h3 a').attribute('href').value
          if li.css('div.img img').attribute('src').present?
            evint[:image_link] = 'https://www.smartshanghai.com' + li.css('div.img img').attribute('src').value
          else
            evint[:image_link] = ''
          end
          evint[:venue_link] = li.css('ul a').attribute('href').value
          category = li.css('ul.riqi span').text.gsub('||','')
          if category == 'NOT TAGGED'
            evint[:category] = 'Other'
          else
            evint[:category] = category
          end
          p evint[:category]
          evint[:venue] = li.css('ul.riqi li').children[5].children.text.strip
          evint[:period] = li.css('ul.riqi li').children[8].text.strip
          p evint[:date] = day
          details = scrape_event_details(evint[:evint_link])
          evint[:address] = details[:address]
          evint[:description] = details[:description]
          evint[:time] = details[:time]
          evint[:wechatid] = details[:wechatid]
          evint[:lng] = details[:lng]
          evint[:lat] = details[:lat]
          Evint.create!(evint)
          puts "Event: #{evint[:title]} created!"
        end
      end
    end
    num += 1
  end
end
create_seeds



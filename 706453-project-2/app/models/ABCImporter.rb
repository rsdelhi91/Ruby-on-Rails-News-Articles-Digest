# This class scrapes the data from the RSS feed: ABC News, based on the link provided 
# in the scrape function. Following which, we store the scraped data in the articles 
# table in the database.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

require 'rss'
require 'open-uri'
require_relative 'article.rb'


class Abcimporter 
    
    # This is the constructor of this class.
	def initialize 
	end

    # This method scrapes the data from the RSS feed for ABC News and 
    # passes it into the articles table in the database, having attributes
    # which are accessible via the data scraped. Since we do not have
    # any authors nor images mentioned for any of the articles being scraped,
    # I have not specified them here.
	def scrape
		url = 'http://www.abc.net.au/sport/syndicate/sport_all.xml'
        open(url) do |rss|
        	feed = RSS::Parser.parse(rss, false)
            puts " "
            puts "*********************************"
        	puts "Title: #{feed.channel.title}"
            puts "--------------------------------"
            feed.items.each do |item|
                tags = tag_article(item.title.to_s)
            	article = Article.new(title: item.title.to_s, 
                                      summary: item.description.to_s.gsub(/\<\/p\>/,'').gsub(/\"/,''), 
                                      link: item.link, 
                                      date: item.pubDate.to_s.gsub(/,/,''),
                                      tag_list: tags, 
                                      source: "ABC")
                article.save
            end
        end
    end

    private

    # This function is used to create tags on articles by breaking the title of the articles
    # into words, joining them then returning them.
    def tag_article article
        tags = article.gsub(/'/,'').split(/\W+/).join(', ')
        tags
    end

end

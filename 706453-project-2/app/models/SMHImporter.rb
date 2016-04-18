# This class scrapes the data from the RSS feed: Sydney Morning Herald based on the link  
# provided in the scrape function. Following which, we pass the scraped data into the
# articles table in the database.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

require 'rss'
require 'open-uri'
require_relative 'article.rb'


class Smhimporter 
    
    # This is the constructor of this class.
	def initialize 
		
	end

    # This method scrapes the data from the RSS feed for the Sydney Morning 
    # Herald and passes it into the articles table in the database, having 
    # atttributes which are accessible via the data scraped. Since we do not
    # have any authors mentioned for any of the articles being scraped, I 
    # have not specified them here. But If we choose another source which
    # does have authors, we can easily add them by including them here.
	def scrape
		url = 'http://www.smh.com.au/rssheadlines/top.xml'
        open(url) do |rss|
        	feed = RSS::Parser.parse(rss, false)
            puts " "
            puts "*********************************"
        	puts "Title: #{feed.channel.title}"
            puts "--------------------------------"
            feed.items.each do |item|
                tags = tag_article(item.title.to_s)
            	article = Article.new(title: item.title.to_s, 
                                      summary: item.description.to_s.gsub(/\"/,''), 
                                      link: item.link, 
                                      date: item.pubDate.to_s.gsub(/,/,''),
                                      tag_list: tags, 
                                      source: "Sydney Morning Herald")
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

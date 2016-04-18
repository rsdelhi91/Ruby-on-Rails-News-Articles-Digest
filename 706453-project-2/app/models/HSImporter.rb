# This class scrapes the data from the RSS feed: the Herald Sun based on the link 
# provided in the scrape function. Following which, we pass the scraped data into 
# the articles table in the database.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

require 'rss'
require 'open-uri'
require_relative 'article.rb'


class Hsimporter 

    # This is the constructor of this class.
	def initialize
	end

    # This method scrapes the data from the RSS feed for Herald Sun and 
    # passes it into the articles table in the database, having attributes 
    # which are accessible via the data scraped. This source may provide
    # data which has unexpected symbols in certain places. This is because
    # this parser cannot parse all types of punctuation (possibly non-ASCII)
    # , hence replaces them with symbols. Since we do not have any authors 
    # mentioned for any of the articles being scraped, I have not specified 
    # them here.
	def scrape
		url = 'http://feeds.news.com.au/heraldsun/rss/heraldsun_news_technology_2790.xml'
        open(url) do |rss|
        	feed = RSS::Parser.parse(rss, false)
        	puts "Title: #{feed.channel.title}"
            puts "*********************************"
            puts " "
            feed.items.each do |item|
                tags = tag_article(item.title.to_s.gsub(/"/,'\''))
            	article = Article.new(title: item.title.to_s.gsub(/"/,'\''), 
                                      summary: item.description.to_s.gsub(/&#8217;/,'\'').gsub(/\"/,'\''), 
                                      image: item.enclosure.url, 
                                      link: item.link,
                                      date: item.pubDate.to_s.gsub(/,/,'').gsub(/\"/,'\'').gsub(/'s/,''), 
                                      tag_list: tags, 
                                      source: "Herald Sun")
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

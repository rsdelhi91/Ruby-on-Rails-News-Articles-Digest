# This class scrapes the data from the JSON source: New York Times, based on the link 
# provided in the scrape function. Following which, we pass the scraped data into 
# the articles table in the database.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

require 'open-uri'
require 'json'
require 'net/http'
require_relative 'article.rb'


class Nytimporter

    # This is the constructor of this class.
	  def initialize
	  end

    # This method scrapes the data from the JSON source for New York Times
    # and passes it into the articles table in the database, having attributes 
    # which are accessible via the data scraped. In this, since the JSON
    # source does not have any authors nor images so I have not used them here.
	  def scrape		
        url = 'http://api.nytimes.com'
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        #If the api being scraped uses https, then set use_ssl to true.
        #http.use_ssl = false
        request_url = '/svc/search/v2/articlesearch.json?q=bangkok+bombings&page=1&sort=newest&api-key=e89effddaf8553d3a95336aaf6882ebe:5:72702694'
        response = http.send_request('GET', request_url)
        article_parse = JSON.parse(response.body)
        article_data= article_parse['response']['docs']
        puts "Title: The New York Times"
        puts "--------------------------------"
        article_data.each do |v|

           tags= tag_article(v['headline']['main'].to_s)
           article = Article.new(title: v['headline']['main'].to_s, 
                                 summary: v['snippet'].to_s, 
                                 link: v['web_url'], 
                                 source: "New York Times", 
                                 date: v['pub_date'].to_s.gsub(/,/,'.'), 
                                 tag_list: tags)
           article.save
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
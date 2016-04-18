# This is the controller for Articles which calls the scrape function in the
# importers located in the model, to scrape the articles from 6 different sources, 
# namely: New York Times, The Age, Herald Sun, Sydney Morning Herald, ABC, and 
# the Wall Street Journal.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

require_relative '../models/NYTImporter.rb'
require_relative '../models/ABCImporter.rb'
require_relative '../models/AgeImporter.rb'
require_relative '../models/SMHImporter.rb'
require_relative '../models/WSJImporter.rb'
require_relative '../models/HSImporter.rb'
require_relative '../models/Importer.rb'

class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:show]
  before_action :authenticate_user
  
  # This is the index method which renders the articles in reverse order.
  def index
    @articles = Article.all.reverse 
  end

  # This is used to relate the users interests with the tags from our scraped articles.
  def my_interests
    @articles = Article.tagged_with(current_user.interest_list, any: true).to_a 
    render 'index'
  end

  def show
  end

  # This gets called whenever the refresh button is clicked by the user. It calls the 
  # the scrape function in all the importers.
  def refresh
    all_importers = Allimporters.new
    all_importer_arr = all_importers.importers
    all_importer_arr.each do |importer_klass|
      importer_klass.scrape
    end
    redirect_to '/articles'
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
  
end

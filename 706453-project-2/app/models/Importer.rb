# This class is used to register all the 6 importers being used in our application
# and passes them to the controller to start the scraping of the news articles.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

require_relative '../models/NYTImporter.rb'
require_relative '../models/ABCImporter.rb'
require_relative '../models/AgeImporter.rb'
require_relative '../models/SMHImporter.rb'
require_relative '../models/WSJImporter.rb'
require_relative '../models/HSImporter.rb'

class Allimporters

  # This is the constructor of the class.
  def initialize
  end

  # This function is used to register all the importers and pass it as an array to 
  # the articles controller. This will be used to call the scrape function on all
  # importers in the controller.
  def importers
    importer_one = Nytimporter.new
    importer_two = Ageimporter.new
    importer_three = Abcimporter.new
    importer_four = Hsimporter.new
    importer_five = Smhimporter.new
    importer_six = Wsjimporter.new
    importer_arr = [importer_one, importer_two, importer_three, importer_four, importer_five, importer_six]
    importer_arr
  end

end
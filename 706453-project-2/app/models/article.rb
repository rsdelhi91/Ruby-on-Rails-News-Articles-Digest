# This class is used to set the associations and also ensure that the articles
# stored in the database are unique and that we are able to tag our articles by
# including the acts as taggable.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

class Article < ActiveRecord::Base
	
  # This specifies the relationships of the articles with the users.
  belongs_to :user

  # This is used to ensure that we do not have any duplicates in the database.
  validates_uniqueness_of :title, scope: [:date]

  # This is to ensure that articles can have tags.
  acts_as_taggable
  
end

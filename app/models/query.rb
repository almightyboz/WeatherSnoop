class Query < ActiveRecord::Base
  has_many :user_queries
  has_many :users, through: :user_queries, source: :user

  # convert user query string to zip code with GM API

  # persist zip code to DB

  # convert zip code to longitude and latitute with GM API

  # search for weather with longitude and latitude

end

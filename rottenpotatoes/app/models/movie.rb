class Movie < ActiveRecord::Base
    
    scope :all_ratings, ->{distinct.order("rating").pluck("rating") }
    scope :with_ratings, ->(selected_ratings) { where(rating:selected_ratings) }
    scope :order_and_ratings, ->(selected_ratings,order) { where(rating:selected_ratings).order(order)}
    scope :same_director_movies, ->(movie) {where(director:movie.director)}
end



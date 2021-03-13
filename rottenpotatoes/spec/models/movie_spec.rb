require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:each) do 
    Movie.create!(:rating => "PG",:title => "Star Wars",:director => 'George Lucas',:release_date => "1977-05-25")
    Movie.create!(:rating => "PG",:title => "Blade Runner",:director => 'Ridley Scott',:release_date => "1982-06-25 ")
    Movie.create!(:rating => "R",:title => "Alien",:director => 'Ridley Scott',:release_date => "1979-05-25")
    Movie.create!(:rating => "R",:title => "THX-1138",:director => 'George Lucas',:release_date => "1971-03-11") 
  end 
  
  it 'should check for all ratings ' do
    expect(Movie.all_ratings).to eq(['PG','R'])
  end
  
  it 'should filter movies with "PG" ratings ' do
    movies = Movie.with_ratings('PG')
    titles = []
    movies.each do |item| 
        titles.append(item.title)
    end
    expect(titles).to eq(['Star Wars','Blade Runner'])
  end
  
  it 'should filter movies with "PG" ratings and sorted by title ' do
    movies = Movie.order_and_ratings('PG',:title)
    titles = []
    movies.each do |item| 
        titles.append(item.title)
    end
    expect(titles).to eq(['Blade Runner','Star Wars'])
  end
  
  it 'should return movies with same director of "Star Wars"' do
    movie = Movie.find_by_title("Star Wars")
    titles = []
    movies = Movie.same_director_movies(movie)
    movies.each do |item| 
        titles.append(item.title)
    end
    expect(titles).to eq(['Star Wars','THX-1138'])
  end
  
  it 'should not return movies with director different to  director of "Star Wars"' do
    movie = Movie.find_by_title("Star Wars")
    titles = []
    movies = Movie.same_director_movies(movie)
    movies.each do |item| 
        titles.append(item.title)
    end
    expect(titles).not_to eq(['Blade Runner','Alien'])
  end
  
  
end

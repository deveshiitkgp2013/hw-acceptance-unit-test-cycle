require 'rails_helper'
require 'spec_helper'


RSpec.describe MoviesController, type: :controller do
    before(:each) do 
    Movie.create!(:rating => "PG",:title => "Star Wars",:director => 'George Lucas',:release_date => "1977-05-25")
    Movie.create!(:rating => "PG",:title => "Blade Runner",:director => 'Ridley Scott',:release_date => "1982-06-25 ")
    Movie.create!(:rating => "R",:title => "Alien",:director => '',:release_date => "1979-05-25")
    Movie.create!(:rating => "R",:title => "THX-1138",:director => 'George Lucas',:release_date => "1971-03-11") 
    end
    
    describe 'GET methods' do
        
        it 'should check working of index method' do
           #get movies_path
           get :index
           expect(response).to render_template("index")
           
        end
        
        it 'should check working of show method' do
           #get '/movies'
           get :show , {:id => 1}
           expect(response).to render_template("show")
           #Movie.should_receive(:with_ratings).with("PG")
        end
        it 'should check working of edit method' do
           get :edit , {:id => 1}
           expect(response).to render_template("edit")
           expect(response).to have_http_status(:success)
        end
        it 'should check working of search_same_director_movies method' do
           #get '/movies'
           get :search_same_director_movies , {:id => 1}
           expect(response).to render_template("search_same_director_movies")
        end
        it 'should check sad path of search_same_director_movies method' do
           #get '/movies'
           get :search_same_director_movies , {:id => 3}
           expect(flash[:notice]).to match(/'Alien' has no director info/)
           expect(response).to redirect_to(movies_path)
        end
    
    end

    describe 'POST methods' do
        it 'should check working of create method' do
           post :create , :movie => {:rating => "PG",:title => "Wars",:director => 'Lucas',:description =>"movie",:release_date => "1977-05-25"}
           expect(response).to redirect_to(movies_path)
           
        end
    end
    
    describe 'PUT methods' do
        it 'should check working of update method' do
           put :update , :id => 1 ,:movie => {:rating => "PG-13",:title => "Wars",:director => 'Lucas',:description =>"movie",:release_date => "1977-05-25"}
           expect(flash[:notice]).to match(/Wars was successfully updated./)
           
        end
    end
    
    describe 'Delete methods' do
        it 'should check working of destroy method' do
           delete :destroy , :id => 1 
           expect(flash[:notice]).to match(/Movie 'Star Wars' deleted./)
           expect(response).to redirect_to(movies_path)
           
        end
    end
    
    describe 'Rest routes for Movies' do
        it 'routes "/movies" to MoviesController' do
           expect(:get => movies_path).to route_to(:controller => "movies", :action => "index")
           
        end
        it 'routes "/movies/:id/search_same_director_movies" to MoviesController' do
           expect(:get => '/movies/:id/search_same_director_movies').to route_to(:controller => "movies", :action => "search_same_director_movies","id"=>":id")
           
        end
        
        
    end
    
    
    
end

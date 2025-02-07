
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(',')
  ratings.each do |rating|
    if uncheck.nil? 
      check(rating)
    else
      uncheck(rating)
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |m_title,m_director|
  
  expect(Movie.find_by_title(m_title).director) == m_director
  
end




Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end







Then /I should (not )?see following movies: (.*)/ do |no, movie_list|
  movie_list = movie_list.split(',')
  movie_list.each do |movie|
    if no.nil?
      if page.respond_to? :should
        page.should have_content(movie)
      else
        assert page.has_content?(movie)
      end
    else
      if page.respond_to? :should
        page.should have_no_content(movie)
      else
        assert page.has_no_content?(movie)
  end
    end
  end
  
end


Then /^I should see all of the movies/ do 
  # Make sure that all the movies in the app are visible in the table
  #fail "Unimplemented"

  expect(all("table#movies tr").count).to eq 11
end


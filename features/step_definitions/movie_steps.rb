# Add a declarative step here for populating the DB with movies.
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings_array = rating_list.split(",")
  if (uncheck != nil)
    ratings_array.each {|rating| uncheck("ratings_#{rating.strip}")}
  else
    ratings_array.each {|rating| check("ratings_#{rating.strip}")}
  end
end

Then /(?:|I ) should see (all|none) of the movies/ do |all_or_none|
  movies = Movie.find(:all,:select => 'title')
  count_of_movies_on_page = 0
  movies.each {|movie|
    count_of_movies_on_page += 1 if page.has_content?(movie.title)
  }
  if (all_or_none == "all")
    puts "count of movies: " + count_of_movies_on_page.to_s
    num_of_movies_in_movie_table = Movie.count('title')
    assert num_of_movies_in_movie_table == count_of_movies_on_page
  elsif (all_or_none == "none")
    puts "count of movies: " + count_of_movies_on_page.to_s
    assert count_of_movies_on_page == 0
  else assert false
  end
end



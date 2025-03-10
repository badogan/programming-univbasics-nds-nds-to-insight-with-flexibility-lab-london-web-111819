# Provided, don't edit
require 'directors_database'

# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point

def movies_with_director_key(name, movies_collection)
  # GOAL: For each Hash in an Array (movies_collection), provide a collection
  # of movies and a directors name to the movie_with_director_name method
  # and accumulate the returned Array of movies into a new Array that's
  # returned by this method.
  # INPUT:
  # * name: A director's name
  # * movies_collection: An Array of Hashes where each Hash represents a movie
  # RETURN:
  # Array of Hashes where each Hash represents a movie; however, they should all have a
  # :director_name key. This addition can be done by using the provided
  # movie_with_director_name method
  index=0 ; modified_movies_collection=[]
  while index<movies_collection.length do
    modified_movies_collection[index] = movie_with_director_name(name,movies_collection[index])
    index = index + 1 
  end
  return modified_movies_collection
end


def gross_per_studio(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return a Hash that includes the total worldwide_gross of all the movies from
  # each studio.
  # INPUT:
  # * collection: Array of Hashes where each Hash where each Hash represents a movie
  # RETURN:
  # Hash whose keys are the studio names and whose values are the sum
  # total of all the worldwide_gross numbers for every movie in the input Hash
  index=0 ; hash_studios_total ={}
  while index < collection.length do
    if hash_studios_total.key?(collection[index][:studio]) 
      hash_studios_total[collection[index][:studio]] = hash_studios_total[collection[index][:studio]] + collection[index][:worldwide_gross]
    else
      hash_studios_total << {collection[index][:studio]=>collection[index][:worldwide_gross]}
    end
    index=index+1 
  end
  return hash_studios_total
end

def movies_with_directors_set(source)
  # GOAL: For each director, find their :movies Array and stick it in a new Array
  # INPUT:
  # * source: An Array of Hashes containing director information including
  # :name and :movies
  # RETURN
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it.
  outer_index= 0 ; return_array =[] ; inner_index=0 
  
  while outer_index < source.length do
    director_name = source[outer_index][:name]
    directors_movies = source[outer_index][:movies]
    while inner_index < directors_movies.length do
      return_array << movie_with_director_name(director_name,directors_movies[inner_index])
      inner_index = inner_index +1 
    end
    outer_index = outer_index + 1 
  end
  return return_array
end

# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end

studios_totals(directors_database)
#p vm
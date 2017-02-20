require 'test_helper'

class FileDb::TableTest < Minitest::Test
  attr_reader :movies, :db, :directors
  def setup
    @db = FileDb::Database.new('fixtures/data.json')
    @movies = @db.table #par défaut "movies" en argument
    @directors = @db.table("directors")
  end
  
  def test_table_returns_table
    assert_equal(db.data["movies"], movies.select)
  end
  
  def test_table_returns_id_movie
    assert_equal(db.data["movies"][1], movies.select(where: { id: 2}))
  end
  
  def test_table_returns_movies_sorted_by_director_id
    arr = []
    db.data["movies"].each do |movie|
      if movie["director_id"] == 1
      arr << movie
      end
    end
    assert_equal(arr, movies.select(where: { director_id: 1}))
  end
  
  def test_table_returns_movies_sorted_by_year
    arr = []
    db.data["movies"].each do |movie|
      if movie["year"] == 1926
      arr << movie
      end
    end
    assert_equal(arr, movies.select(where: { year: 1926}))
  end
  
  def test_table_returns_movies_sorted_by_title
    arr = []
    db.data["movies"].each do |movie|
      if movie["title"] == 'Psycho'
      arr << movie
      end
    end
    assert_equal(arr, movies.select(where: { title: "Psycho"}))
  end
  
  def test_table_returns_movies_with_new_movie
    new_list = db.data["movies"].dup
    data_length = db.data["movies"].length
    new_movie = { title: "Birds", year: 1962, director_id: 2 }.merge!(id: "#{data_length}".to_i + 1)
    new_list << new_movie
    assert_equal(new_list.last, movies.insert({ title: "Birds", year: 1962, director_id: 2 }))
    
  end
  
  def test_table_returns_movies_with_movie_updated
    assert_equal({"id"=>6, "title"=>"Psycho", "year"=>1963, "director_id"=>2}, movies.update(where: { id: 6 }, values: { year: 1963 }))
  end
end
















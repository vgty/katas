require 'test_helper'
require 'json'

class FileDb::DatabaseTest < Minitest::Test
  def setup
    @db = FileDb::Database.new('fixtures/data.json')
  end

  def test_table_names_returns_an_array
    assert_kind_of(Array, @db.table_names)
  end

  def test_table_returns_table_name
    assert_equal(["movies", "directors"], @db.table_names)
  end
  
end

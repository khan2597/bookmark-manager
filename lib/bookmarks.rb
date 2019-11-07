require 'pg'

class Bookmarks
  attr_reader :url, :title, :id

  def initialize(url:, title:, id:)
    @title = title 
    @url = url
    @id = id
  end

  def self.all
      if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'test')
      else
        connection = PG.connect(dbname: 'bookmark_manager')
      end
  
      result = connection.exec("SELECT * FROM bookmarks")
      result.map do |bookmark|
        Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
      end
  end

  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title")
    bookmark = result[0]
    Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
  end

  def self.delete(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end
end
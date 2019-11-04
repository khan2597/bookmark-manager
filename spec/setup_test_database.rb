require 'pg'

def setup_test_database
    p "Setting up test database..."

    connection = PG.connect(dbname: 'test')

    connection.exec("TRUNCATE bookmarks;")
end
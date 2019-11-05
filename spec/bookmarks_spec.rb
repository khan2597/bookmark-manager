require 'bookmarks'

describe Bookmarks do
    it 'returns instance of bookmarks class' do
        expect(subject).to be_an_instance_of(Bookmarks)
    end

    it 'returns the list of bookmarks' do
        connection = PG.connect(dbname: 'test')

        # Add the test data
        connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
        connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
        connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

        bookmarks = Bookmarks.all

        expect(bookmarks).to include "http://www.makersacademy.com"
        expect(bookmarks).to include "http://www.destroyallsoftware.com"
        expect(bookmarks).to include "http://www.google.com"
    end

    describe '.create' do
        it 'creates a new bookmark' do
            Bookmarks.create(url: 'http://www.testbookmark.com')
            expect(Bookmarks.all).to include 'http://www.testbookmark.com'
        end
    end
end
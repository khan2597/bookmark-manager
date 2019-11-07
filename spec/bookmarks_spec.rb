require 'bookmarks'

describe Bookmarks do
    it 'returns the list of bookmarks' do
        connection = PG.connect(dbname: 'test')

        # Add the test data
        bookmark = Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")
        Bookmarks.create(url: "http://www.destroyallsoftware.com", title: "Destroy all Software" )
        Bookmarks.create(url: "http://www.google.com", title: "Google")

        bookmarks = Bookmarks.all

        expect(bookmarks.length).to eq 3
        expect(bookmarks.first).to be_a Bookmarks
        expect(bookmarks.first.id).to eq bookmark.id
        expect(bookmarks.first.title).to eq 'Makers Academy'
        expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end

    describe '.create' do
        it 'creates a new bookmark' do
            bookmark = Bookmarks.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
            persisted_data = PG.connect(dbname: 'test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")

            expect(bookmark).to be_a Bookmarks
            expect(bookmark.id).to eq persisted_data.first['id']
            expect(bookmark.title).to eq persisted_data.first['title'] 
            expect(bookmark.url).to eq persisted_data.first['url']
        end
    end

    describe '.delete' do
        it 'deletes the bookmark' do
            bookmark = Bookmarks.create(title: 'Google', url: 'www.google.co.uk')
            Bookmarks.delete(id: bookmark.id)
            expect(Bookmarks.all.length).to eq 0
        end
    end
end
feature 'Viewing bookmarks' do
    scenario 'visiting the index page' do
      Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Bookmarks.create(url: "http://www.destroyallsoftware.com", title: "Destroy all Software" )
      Bookmarks.create(url: "http://www.google.com", title: "Google")
      
      visit('/bookmarks')
      
      expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
      expect(page).to have_link('Destroy all Software', href: 'http://www.destroyallsoftware.com')
      expect(page).to have_link('Google', href: 'http://www.google.com')
    end
end
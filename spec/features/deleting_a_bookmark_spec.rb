feature 'Deleting a bookmark' do
    scenario 'A user can delete a bookmark' do
        Bookmarks.create(url: 'www.youtube.com', title: 'Youtube')
        visit('/bookmarks')
        expect(page).to have_link('Youtube', href: 'www.youtube.com')

        first('.bookmark').click_button 'Delete'

        expect(page).not_to have_link('Youtube', href: 'www.youtube.com')
    end
end
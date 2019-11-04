require 'sinatra/base'
require './lib/bookmarks'

class BookmarkManager < Sinatra::Base
    get '/' do
        'Hello world'
    end

    get '/bookmarks' do
        @bookmarks = Bookmarks.all
        p @bookmarks
        erb :'bookmarks/index'
    end

    run! if app_file == $0
end
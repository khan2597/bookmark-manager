require 'sinatra/base'
require './lib/bookmarks'

class BookmarkManager < Sinatra::Base
    get '/' do
        'Hello world'
    end

    get '/bookmarks/new' do
        erb :"/bookmarks/new"
    end

    post '/bookmarks' do
        url = params['url']
        connection = PG.connect(dbname: 'test')
        connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
        redirect '/bookmark/new'
    end

    run! if app_file == $0
end
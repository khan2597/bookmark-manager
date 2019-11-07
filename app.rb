require 'sinatra/base'
require './lib/bookmarks'

class BookmarkManager < Sinatra::Base
    enable :sessions, :method_override
    
    delete '/bookmarks/:id' do
        Bookmarks.delete(id: params[:id])
        redirect '/bookmarks'
    end

    get '/' do
        'Hello world'
    end

    get '/bookmarks' do
        @bookmarks = Bookmarks.all
        erb :"/bookmarks/index"
    end

    get '/bookmarks/new' do
        erb :"/bookmarks/new"
    end

    post '/bookmarks' do
        Bookmarks.create(url: params[:url], title: params[:title])
        redirect '/bookmarks'
    end

    run! if app_file == $0
end
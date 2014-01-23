require 'sinatra'
require 'pry'
require 'pry-debugger'
require 'pg'
require 'active_support/all'
require 'active_record'
require 'sinatra/reloader' if development?
require 'active_record/validations'


ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :username => 'mathildathompson',
    :database => 'blogs'
)

class Blog < ActiveRecord::Base
    validates :name, :presence => true
end

get '/' do
    @blog = Blog.all
    erb :home
end

get '/blog/:id' do |id|
    @blog = Blog.find (id)
    erb :blog
end

get '/new' do
    erb :new
end

post '/create' do
    @new_blog = Blog.create(params[:blogs])
    if @new_blog.valid?
        redirect to '/'
    else
        erb :edit
    end
end

get '/blogs/:id/update' do
    @blog = Blog.find(params[:id])
    erb :update
end

post '/blogs/:id/update' do
    @blog = Blog.find(params[:id])
    @blog.update_attributes(params[:blogs])
    redirect to "/blog/#{@blog.id}"
end

delete '/blogs/:id/delete' do
    binding.pry
    @blog = Blog.find(params[:id])
    @blog.delete
    redirect to '/'
end

# get '/edit' do
#     erb :edit
# end

# post '/blog/:id/edit' do
#     sql = "UPDATE cats set name='#{params[:name]}', photo='#{params[:photo]}', breed='#{params[:breed]}' WHERE id=#{params[:id]}"
#     run_sql(sql)
#     redirect to '/'

# end



# def run_sql(sql)
#     conn = PG.connect(:dbname => 'Blogosphere')
#     result = conn.exec(sql)
#     conn.close
#     puts result
#     result
# end

# sql = "INSERT INTO CATS (name, photo, breed) values('#{params[:name]}', '#{params[:photo]}', '#{params[:breed]}');"
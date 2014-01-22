require 'sinatra'
require 'pry'
require 'pg'
require 'active_support/all'

get '/' do
    sql = "SELECT * FROM blog;"
    @result = run_sql(sql)
    erb :home
end

get '/new' do
    erb :new
end

post '/create' do
    sql = "INSERT INTO blog (name, comments) values('#{params[:name]}', '#{params[:comments]}');"
    run_sql(sql)
    redirect to '/'
end

post 'blog/:id/edit' do
    sql = "UPDATE cats set name='#{params[:name]}', photo='#{params[:photo]}', breed='#{params[:breed]}' WHERE id=#{params[:id]}"
    run_sql(sql)
    redirect to '/'

end



def run_sql(sql)
    conn = PG.connect(:dbname => 'Blogosphere')
    result = conn.exec(sql)
    conn.close
    puts result
    result
end

# sql = "INSERT INTO CATS (name, photo, breed) values('#{params[:name]}', '#{params[:photo]}', '#{params[:breed]}');"
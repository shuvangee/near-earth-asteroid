require "sinatra"
require "sinatra/reloader"
#require "http"

get("/") do
  erb(:homepage)
end

get("/enter-dates") do
  erb(:dates)
end


get("/asteroids/results") do
  @start= params.fetch("start_date")
  @end= params.fetch("end_date")
  @url= "https://api.nasa.gov/neo/rest/v1/feed?start_date=#{@start}&end_date=#{@end}&api_key=#{ENV.fetch("NASA_API_KEY")}"
  @raw_response=HTTP.get(@url)

  @string_response= @raw_response.to_s

  @parsed_response= JSON.parse(@string_response)
  
  @list_of_objects= @parsed_response.fetch("near_earth_objects")
  
  erb(:asteroids_results)
end

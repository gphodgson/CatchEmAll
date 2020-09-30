require "net/http"
require "json"
require "pp"
require "rmagick"

Pokemon.delete_all
Stat.delete_all

url = "https://pokeapi.co/api/v2/pokemon/?limit=151"
uri = URI(url)
response = JSON.parse(Net::HTTP.get(uri))

response["results"].each do |pokemon_ref|
  url = pokemon_ref["url"]
  uri = URI(url)

  pokemon_res = JSON.parse(Net::HTTP.get(uri))

  image = Magick::ImageList.new
  urlimage = URI.open("https://pokeres.bastionbot.org/images/pokemon/#{pokemon_res['id']}.png") # Image Remote URL
  image.from_blob(urlimage.read)

  pix = image.scale(1, 1)
  average_color = pix.pixel_color(0, 0).to_color[0..6]

  pokemon = Pokemon.new(
    name:           pokemon_res["name"],
    pokedex_number: pokemon_res["id"],
    img:            "https://pokeres.bastionbot.org/images/pokemon/#{pokemon_res['id']}.png",
    thumb:          pokemon_res["sprites"]["versions"]["generation-i"]["yellow"]["front_default"],
    color:          average_color
  )

  if pokemon&.valid?
    pokemon.save
    puts pokemon.inspect
  else
    puts "error with pokemon `#{pokemon_res['name']}`"
  end
end

puts "Added #{Pokemon.count} Pokemon."

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

  total = 0
  avg   = { r: 0.0, g: 0.0, b: 0.0 }
  image.quantize.color_histogram.each do |c, n|
    avg[:r] += n * c.red
    avg[:g] += n * c.green
    avg[:b] += n * c.blue
    total   += n
  end
  %i[r g b].each { |comp| avg[comp] /= total }
  %i[r g b].each { |comp| avg[comp] = (avg[comp] / Magick::QuantumRange * 255).to_i }

  average_color = "##{avg[:r].to_s(16)}#{avg[:g].to_s(16)}#{avg[:b].to_s(16)}"
  puts average_color

  pokemon = Pokemon.new(
    name:           pokemon_res["name"],
    pokedex_number: pokemon_res["id"],
    img:            "https://pokeres.bastionbot.org/images/pokemon/#{pokemon_res['id']}.png",
    thumb:          pokemon_res["sprites"]["versions"]["generation-i"]["yellow"]["front_default"],
    color:          average_color
  )

  if pokemon&.valid?
    pokemon.save
    # puts pokemon.inspect
  else
    puts "error with pokemon `#{pokemon_res['name']}`"
  end
end

puts "Added #{Pokemon.count} Pokemon."

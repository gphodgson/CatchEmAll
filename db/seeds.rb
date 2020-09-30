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

  average_color = get_average_color(pokemon_res["sprites"]["versions"]["generation-i"]["yellow"]["front_default"])

  puts "#{pokemon_res['name'].capitalize}: ##{pokemon_res['id']} | color: #{average_color}"

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

def get_average_color(img)
  image = Magick::ImageList.new
  urlimage = URI.open(img) # Image Remote URL
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
  pix = Magick::Pixel.from_color(average_color)
  hlsa = pix.to_hsla
  hlsa[1] += 100.0
  hlsa[2] -= 50

  hlsa[2] = 0 unless hlsa[2] > 0
  average_color = Magick::Pixel.from_hsla(hlsa[0], hlsa[1], hlsa[2], hlsa[3])
  average_color = "##{(average_color.red.to_i / 256).to_s(16)}#{(average_color.green.to_i / 256).to_s(16)}#{(average_color.blue.to_i / 256).to_s(16)}"
end

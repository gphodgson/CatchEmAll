require "net/http"
require "json"
require "pp"
require "rmagick"

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

Stat.delete_all
Pokemon.delete_all

url = "https://pokeapi.co/api/v2/pokemon/?limit=151"
uri = URI(url)
response = JSON.parse(Net::HTTP.get(uri))

response["results"].each do |pokemon_ref|
  url = pokemon_ref["url"]
  uri = URI(url)

  pokemon_res = JSON.parse(Net::HTTP.get(uri))

  species_url = "https://pokeapi.co/api/v2/pokemon-species/#{pokemon_res['id']}/"
  species_uri = URI(species_url)
  pokemon_species = JSON.parse(Net::HTTP.get(species_uri))

  average_color = get_average_color(pokemon_res["sprites"]["versions"]["generation-i"]["yellow"]["front_default"])

  puts "#{pokemon_res['name'].capitalize}: ##{pokemon_res['id']}     | color: #{average_color}"

  pokemon = Pokemon.new(
    name:           pokemon_res["name"],
    alt_name:       "n/a",
    pokedex_number: pokemon_res["id"],
    description:    pokemon_species["flavor_text_entries"][0]["flavor_text"].delete("\f"),
    img:            "https://pokeres.bastionbot.org/images/pokemon/#{pokemon_res['id']}.png",
    thumb:          pokemon_res["sprites"]["versions"]["generation-i"]["yellow"]["front_default"],
    color:          average_color,
    weight:         pokemon_res["weight"].to_i / 10
  )

  if pokemon&.valid?
    pokemon.save
    stat = pokemon.stat = Stat.create(
      hp:              pokemon_res["stats"][0]["base_stat"],
      attack:          pokemon_res["stats"][1]["base_stat"],
      defense:         pokemon_res["stats"][2]["base_stat"],
      special_attack:  pokemon_res["stats"][3]["base_stat"],
      special_defense: pokemon_res["stats"][4]["base_stat"],
      speed:           pokemon_res["stats"][5]["base_stat"]
    )

    if stat&.valid?
      stat.save
      pokemon.stat = stat
    else
      puts "error with stat of `#{pokemon_res['name']}`"
      puts stat.inspect
      pp stat.errors
    end
  else
    puts "error with pokemon `#{pokemon_res['name']}`"
    pp pokemon.errors
  end
end

puts "Added #{Stat.count} Stats."
puts "Added #{Pokemon.count} Pokemon."
puts "Added #{Location.count} Locations"

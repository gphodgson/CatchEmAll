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
  "##{(average_color.red.to_i / 256).to_s(16)}#{(average_color.green.to_i / 256).to_s(16)}#{(average_color.blue.to_i / 256).to_s(16)}"
end

Stat.delete_all
Encounter.delete_all
Pokemon.delete_all
Location.delete_all

pokemons_url = "https://pokeapi.co/api/v2/pokemon/?limit=151"
pokemons_uri = URI(pokemons_url)
pokemons_res = JSON.parse(Net::HTTP.get(pokemons_uri))

pokemons_res["results"].each do |pokemon_ref|
  pokemon_url = pokemon_ref["url"]
  pokemon_uri = URI(pokemon_url)
  pokemon_res = JSON.parse(Net::HTTP.get(pokemon_uri))

  species_url = "https://pokeapi.co/api/v2/pokemon-species/#{pokemon_res['id']}/"
  species_uri = URI(species_url)
  species_res = JSON.parse(Net::HTTP.get(species_uri))

  average_color = get_average_color(pokemon_res["sprites"]["versions"]["generation-i"]["yellow"]["front_default"])
  description = if species_res["flavor_text_entries"][0]["flavor_text"].include?("\f")
                  species_res["flavor_text_entries"][0]["flavor_text"].gsub!("\f", " ")
                else
                  species_res["flavor_text_entries"][0]["flavor_text"]
                end

  pokemon = Pokemon.create(
    name:           pokemon_res["name"],
    alt_name:       "n/a",
    pokedex_number: pokemon_res["id"],
    description:    description,
    img:            "https://pokeres.bastionbot.org/images/pokemon/#{pokemon_res['id']}.png",
    thumb:          pokemon_res["sprites"]["versions"]["generation-i"]["yellow"]["front_default"],
    color:          average_color,
    weight:         pokemon_res["weight"].to_i / 10
  )

  if pokemon&.valid?
    puts "Added pokemon #{pokemon.name}"

    stat = pokemon.stat = Stat.create(
      hp:              pokemon_res["stats"][0]["base_stat"],
      attack:          pokemon_res["stats"][1]["base_stat"],
      defense:         pokemon_res["stats"][2]["base_stat"],
      special_attack:  pokemon_res["stats"][3]["base_stat"],
      special_defense: pokemon_res["stats"][4]["base_stat"],
      speed:           pokemon_res["stats"][5]["base_stat"]
    )

    if stat&.valid?
      puts "Added stats for '#{pokemon.name}'"

      encounters_url = "https://pokeapi.co/api/v2/pokemon/#{pokemon_res['id']}/encounters"
      encounters_uri = URI(encounters_url)
      encounters = JSON.parse(Net::HTTP.get(encounters_uri))

      encounters.each do |encounter_res|
        encounter_res["version_details"].each do |encounter_versions|
          version = encounter_versions["version"]["name"]
          next unless (version == "yellow") || (version == "blue") || (version == "red")

          location = Location.find_or_create_by(name: encounter_res["location_area"]["name"].dup.gsub!("-", " "))

          encounter = pokemon.encounters.create(
            location: location,
            chance:   encounter_versions["encounter_details"][0]["chance"],
            method:   encounter_versions["encounter_details"][0]["method"]["name"],
            game:     version
          )

          if encounter&.valid?
            puts "Added encounter at `#{location.name}`"
          else
            puts "Error with encounter at `#{location.name}`"
            pp encounter.errors.messages
          end
        end
      end
    else
      puts puts "Error with pokemon stats: #{pokemon_res['name']}"
    end
  else
    puts "Error with pokemon: #{pokemon_res['name']}"
    pp pokemon.errors.messages
  end
end

puts "Added #{Stat.count} Stats."
puts "Added #{Pokemon.count} Pokemon."
puts "Added #{Location.count} Locations"
puts "Added #{Encounter.count} Encounters"

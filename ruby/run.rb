require_relative "bot"
require_relative "config"
require_relative "player"
require_relative "utils"

# Chargement du dictionnaire
mots = File.readlines("data/mots.txt", chomp: true)
dictionnaire = initialiser_dictionnaire(mots)

case MODE

when "player"
  mot = LE_MOT ? LE_MOT : mots.sample
  player_run(mot, dictionnaire)

when "bot"
  mot = LE_MOT ? LE_MOT : mots.sample
  propositions, essais = bot_run(VERSION_BOT, mot, dictionnaire)

  afficher(propositions)
  puts "Trouvé en #{essais} tentatives."

when "benchmark"
  puts "TODO"
#   if ECHANTILLON_BENCHMARK
#     mots = File.readlines(ECHANTILLON_BENCHMARK, chomp: true)
#   end
#   benchmark = {}
#   mots.each do |mot|
#     benchmark[mot] = bot_run(VERSION_BOT, mot, dictionnaire)
#   end
#   puts benchmark

else
  puts "Le mode \"#{MODE}\n n'existe pas. Préciser \"player\", \"bot\" ou \"benchmark\" dans le fichier config.rb"
end

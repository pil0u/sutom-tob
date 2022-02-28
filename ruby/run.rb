# frozen_string_literal: true

require 'open-uri'

require_relative 'bot'
require_relative 'bots/v0'
require_relative 'bots/v1'
require_relative 'bots/v2'
require_relative 'bots/v3'
require_relative 'config'
require_relative 'player'
require_relative 'utils'

mots = File.readlines('data/mots.txt', chomp: true)
dictionnaire = initialiser_dictionnaire(mots)

case MODE

when 'sutom'
  puts "Grille ##{JOUR_SUTOM} de SUTOM"
  mot = URI.parse("https://sutom.nocle.fr/mots/#{JOUR_SUTOM}.txt").read

  matrice = JSON.load_file("data/#{mot.size}#{mot[0]}/matrice.json")
  mots_proposables = File.readlines("data/#{mot.size}#{mot[0]}/liste.txt", chomp: true)

  propositions_h = player_run(mot, mots_proposables)

  resultats_bots = []

  (1..DERNIERE_VERSION_BOT).each do |version|
    bot = method("bot_v#{version}".to_sym)
    propositions = bot_run(mot, mots_proposables, matrice, bot)

    puts "\nbot_v#{version}"
    afficher(propositions)

    resultats_bots << propositions.size
  end

  puts ligne_tableau_sutom(JOUR_SUTOM, mot, propositions_h, resultats_bots)

when 'player'
  mot = LE_MOT || mots.sample
  mots_proposables = dictionnaire[mot.size][mot[0]]

  player_run(mot, mots_proposables)

when 'bot'
  begin
    bot = method("bot_v#{VERSION_BOT}".to_sym)
  rescue NameError
    puts "La version #{VERSION_BOT} du bot n'existe pas."
    puts 'Il faut la créer ou choisir une autre version dans le fichier config.rb'
    return
  end

  mot = LE_MOT || mots.sample

  matrice = JSON.load_file("data/#{mot.size}#{mot[0]}/matrice.json")
  mots_proposables = File.readlines("data/#{mot.size}#{mot[0]}/liste.txt", chomp: true)

  propositions = bot_run(mot, mots_proposables, matrice, bot)

  afficher(propositions)
  puts "Trouvé en #{propositions.size} tentatives."

when 'benchmark'
  # OPTIM: garder en mémoire les mots_proposables écartés
  begin
    bot = method("bot_v#{VERSION_BOT}".to_sym)
  rescue NameError
    puts "La version #{VERSION_BOT} du bot n'existe pas."
    puts 'Il faut la créer ou choisir une autre version dans le fichier config.rb'
    return
  end

  puts 'TODO'

  # if ECHANTILLON_MOTS
  #   mots = File.readlines(ECHANTILLON_MOTS, chomp: true)
  # end

  # benchmark = {}

  # mots.each do |mot|
  #   mots_proposables = dictionnaire[mot.size][mot[0]]
  #   benchmark[mot] = bot_run(mot, mots_proposables, bot)
  # end

  # essais = benchmark.map { |k, v| v[1] }
  # moyenne = essais.sum / essais.size.to_f

  # puts moyenne

else
  puts "Le mode \"#{MODE}\" n'existe pas. Préciser \"player\", \"bot\" ou \"benchmark\" dans le fichier config.rb"
end

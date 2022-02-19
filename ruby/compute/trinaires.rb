# Ce script calcule et stocke au format JSON les résultats de
# chaque mot vs toutes les propositions possibles.
# 
# Il a tourné en 1h 22m 47s lors d'un live Twitch.
# Les fichiers générés pèsent 7.4Go.

require "json"
require_relative "../utils"

mots = File.readlines("data/mots.txt", chomp: true)
dictionnaire = initialiser_dictionnaire(mots)

dictionnaire.each do |taille_mot, v|
  v.each do |premiere_lettre, sous_dictionnaire|

    trinaires = {}

    sous_dictionnaire.each do |mot|
      hash_mot = {}

      sous_dictionnaire.each do |proposition|

        resultat = Array.new(proposition.length, 0)
        lettres_du_mot = mot.chars
        indices_restants = []

        proposition.each_char.with_index do |lettre, idx|
          if lettre == lettres_du_mot[idx]
            resultat[idx] = 2
            lettres_du_mot[idx] = "#"
          else
            indices_restants << idx
          end
        end

        indices_restants.each do |idx|
          if lettres_du_mot.include?(proposition[idx])
            resultat[idx] = 1
          end
        end

        trinaire_decimal = resultat.reverse.reduce { |a, b| a*3 + b }
        hash_mot[proposition] = trinaire_decimal
      end

      trinaires[mot] = hash_mot
    end

    File.open("data/#{taille_mot}#{premiere_lettre}.json", "w") do |f|
      JSON.dump(trinaires, f)
    end

    puts "#{taille_mot}#{premiere_lettre} - done!"
  end
end

# frozen_string_literal: true

# Ce script calcule et stocke au format JSON les résultats de chaque
# mot vs toutes les propositions possibles, sous forme d'une matrice.
#
# Ces résultats sont encodés sous forme de trinaires :
# GARAGE vs GRUGER
#   => 🟥🟡🟦🟡🟡🟦
#   => [2, 1, 0, 1, 1, 0]
#   => 011012
#   => 113
#
# GRUGER vs GARAGE
#   => 🟥🟦🟡🟦🟡🟡
#   => [2, 0, 1, 0, 1, 1]
#   => 110102
#   => 335

require 'fileutils'
require 'json'
require_relative '../utils'

mots = File.readlines('data/mots.txt', chomp: true)
dictionnaire = initialiser_dictionnaire(mots)

dictionnaire.each do |taille_mot, v|
  v.each do |premiere_lettre, sous_dictionnaire|
    taille_dictionnaire = sous_dictionnaire.size.to_f

    niveau = "#{taille_mot}#{premiere_lettre}"
    FileUtils.mkdir_p("data/#{niveau}")

    matrice = Array.new(taille_dictionnaire) { Array.new(taille_dictionnaire) }

    sous_dictionnaire.each_with_index do |mot, idx_mot|
      sous_dictionnaire.each_with_index do |proposition, idx_proposition|
        resultat = Array.new(proposition.size, 0)
        lettres_du_mot = mot.chars
        indices_restants = []

        # 1ère passe sur toutes les lettres pour trouver les bien placées
        proposition.each_char.with_index do |lettre, idx|
          if lettre == lettres_du_mot[idx]
            resultat[idx] = 2
            lettres_du_mot[idx] = '#'
          else
            indices_restants << idx
          end
        end

        # 2ème passe sur les lettres autres que bien placées
        indices_restants.each do |idx|
          if lettres_du_mot.include?(proposition[idx])
            resultat[idx] = 1
            lettres_du_mot[idx] = '#'
          end
        end

        trinaire_decimal = resultat.reverse.reduce { |a, b| (a * 3) + b }

        matrice[idx_mot][idx_proposition] = trinaire_decimal
      end
    end

    File.open("data/#{niveau}/liste.txt", 'w') do |f|
      f.puts(sous_dictionnaire)
    end

    File.open("data/#{niveau}/matrice.json", 'w') do |f|
      JSON.dump(matrice, f)
    end

    puts "#{niveau} - done!"
  end
end

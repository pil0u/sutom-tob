# frozen_string_literal: true

require 'byebug'
require 'json'

def bot_v4(mots_proposables,
           propositions,
           positions,
           compteur,
           _compteur_exact)

  n = positions.size
  l = positions[0].first

  entropies = JSON.load_file("data/#{n}#{l}/entropies.json")
  # matrice = JSON.load_file("data/#{n}#{l}/matrice.json")

  # Si c'est ma première proposition, renvoyer le mot à l'entropie la plus élevée
  return entropies.first[0] if propositions.empty?

  # Sinon, filtrer les mots véritablement éligibles à partir des propositions passées
  # A OPTIMISER (plus tard ?)
  # Prendre le mot à l'entropie la plus élevée

  mots_potentiels = []

  mots_proposables.each do |mot|
    skip = false

    # Vérification n°1 : le mot ne doit pas avoir été déjà proposé
    next if propositions.has_key?(mot)

    # Vérification n°2 : le mot doit contenir les lettres bien placées
    positions.each_with_index do |e, idx|
      if e.size == 1
        skip = true if mot[idx] != e.first
      end
    end
    next if skip

    # Vérification n°3 : le mot ne doit pas contenir les lettres totalement écartées
    compteur.select { |_k, v| v == 0 }.each_key do |lettre|
      if mot.include?(lettre)
        skip = true
        break
      end
    end
    next if skip

    # Vérification n°4 : le mot doit contenir les lettres qu'on sait dans le mot
    lettres_infos = compteur.map { |k, v| Array.new(v) { k } }.flatten
    mot.each_char do |lettre|
      lettres_infos.delete_at(lettres_infos.index(lettre) || lettres_infos.size)
    end
    next if lettres_infos.any?

    # Vérification n°5 : chaque lettre doit être possible à sa position
    mot.each_char.with_index do |lettre, idx|
      unless positions[idx].include?(lettre)
        skip = true
        break
      end
    end
    next if skip

    mots_potentiels << mot
  end

  # puts mots_potentiels.count

  # OPTIM: recalculer les entropies de manière dynamique
  entropies.each_key do |m|
    return m if mots_potentiels.include?(m)
  end
end

# frozen_string_literal: true

def bot_v1(mots_proposables,
           propositions,
           positions,
           compteur,
           _compteur_exact)

  mots_proposables.each do |mot|
    skip = false

    # Vérification n°1 : le mot ne doit pas avoir été déjà proposé
    next if propositions.key?(mot)

    # Vérification n°2 : le mot doit contenir les lettres bien placées
    positions.each_with_index do |position, idx|
      skip = true if position.size == 1 && (mot[idx] != position.first)
    end
    next if skip

    # Vérification n°3 : le mot ne doit pas contenir les lettres écartées
    compteur.select { |_k, v| v.zero? }.each_key do |l|
      skip = true if mot.include?(l)
    end
    next if skip

    return mot
  end
end

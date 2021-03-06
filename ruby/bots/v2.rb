# frozen_string_literal: true

def bot_v2(mots_proposables,
           propositions,
           positions,
           compteur,
           _compteur_exact)

  mots_proposables.each do |mot|
    skip = false

    # Vérification n°1 : le mot ne doit pas avoir été déjà proposé
    next if propositions.key?(mot)

    # Vérification n°2 : le mot doit contenir les lettres bien placées
    positions.each_with_index do |e, idx|
      skip = true if e.size == 1 && (mot[idx] != e.first)
    end
    next if skip

    # Vérification n°3 : le mot ne doit pas contenir les lettres écartées
    compteur.select { |_k, v| v.zero? }.each_key do |l|
      skip = true if mot.include?(l)
    end
    next if skip

    # Vérification n°4 : le mot doit contenir les lettres qu'on sait dans le mot
    lettres_infos = compteur.map { |k, v| Array.new(v) { k } }.flatten
    mot.each_char do |l|
      lettres_infos.delete_at(lettres_infos.index(l) || lettres_infos.size)
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

    return mot
  end
end

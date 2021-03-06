# frozen_string_literal: true

def bot_v3(mots_proposables,
           propositions,
           positions,
           compteur,
           _compteur_exact)

  mots_potentiels = []

  mots_proposables.each do |mot|
    skip = false

    # Vérification n°1 : le mot ne doit pas avoir été déjà proposé
    next if propositions.key?(mot)

    # Vérification n°2 : le mot doit contenir les lettres bien placées
    positions.each_with_index do |e, idx|
      skip = true if e.size == 1 && (mot[idx] != e.first)
    end
    next if skip

    # Vérification n°3 : le mot ne doit pas contenir les lettres totalement écartées
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

    # "to".chars.zip([Set["A", "Z"], Set["B", "C"]]) { |l, pos| skip = true unless pos.include?(l) }

    mots_potentiels << mot
  end

  frequences = [{ positions[0].first => 1 }]
  (positions.size - 1).times { frequences << Hash.new(0).clone }

  mots_potentiels.each do |mot|
    frequences[1..].each_index do |idx|
      frequences[idx + 1][mot[idx + 1]] += 1
    end
  end

  scores = {}

  mots_potentiels.each do |mot|
    score = 1

    mot.each_char.with_index do |lettre, idx|
      score *= frequences[idx][lettre]
    end

    scores[mot] = score
  end

  scores.min_by { |_k, v| -v }.first
end

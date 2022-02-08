# TODO: Calcul des fréquences des lettres

def bot_v2(mots_proposables,
           propositions,
           positions,
           compteur,
           compteur_exact)

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

    # Vérification n°3 : le mot ne doit pas contenir les lettres écartées
    compteur.select { |_k, v| v == 0 }.keys.each do |l|
      skip = true if mot.include?(l)
    end
    next if skip

    # Vérification n°4 : le mot doit contenir les lettres qu'on sait dans le mot
    lettres_infos = compteur.map { |k, v| [k] * v }.flatten
    mot.chars.each do |l|
      lettres_infos.delete_at(lettres_infos.index(l) || lettres_infos.length)
    end
    next if lettres_infos.any?

    return mot
  end
end

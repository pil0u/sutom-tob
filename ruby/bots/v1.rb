def bot_v1(mots_proposables, propositions, emplacements, infos)
  mots_possibles = []

  mots_proposables.each do |mot|
    skip = false

    # Vérification n°1 : le mot ne doit pas avoir été déjà proposé
    next if propositions.has_key?(mot)

    # Vérification n°2 : le mot doit contenir les lettres bien placées
    emplacements.each_with_index do |e, idx|
      if e.size == 1
        skip = true if mot[idx] != e.first
      end
    end
    next if skip

    # Vérification n°3 : le mot ne doit pas contenir les lettres écartées
    infos.select { |_k, v| v == 0 }.keys.each do |l|
      skip = true if mot.include?(l)
    end
    next if skip

    mots_possibles << mot
  end

  mots_possibles.first
end

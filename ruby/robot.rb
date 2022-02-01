def robot(propositions, mots_proposables, bien_placees, contenues, absentes, emplacements)
  mots_possibles = []

  mots_proposables.each do |mot|
    next if propositions.has_key?(mot)

    is_valid = true

    # Les mots possibles doivent contenir les lettres bien placées
    bien_placees.each_with_index do |lettre, idx|
      next if lettre == "."

      is_valid = false if mot[idx] != lettre
    end
    next unless is_valid

    # Les mots possibles ne doivent pas contenir les lettres écartées
    next unless (Set.new(mot.chars) & absentes).empty?

    # TODO: Les mots possibles doivent contenir les lettres contenues
    # TODO: Calcul des fréquences des lettres

    mots_possibles << mot
  end

  # sleep(0.5)
  mots_possibles.sample
end

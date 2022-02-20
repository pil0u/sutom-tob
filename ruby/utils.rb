def initialiser_dictionnaire(liste_mots)
  dict = {}

  liste_mots.each do |mot|
    taille = mot.size
    premiere_lettre = mot[0]
  
    if dict.has_key?(taille)
      if dict[taille].has_key?(premiere_lettre)
        dict[taille][premiere_lettre] << mot
      else
        dict[taille][premiere_lettre] = [mot]
      end
    else
      dict[taille] = { premiere_lettre => [mot] }
    end
  end

  return dict
end

def valide?(mot_propose, mots_proposables, mot_a_trouver)  
  if mot_propose.size != mot_a_trouver.size
    puts "Tu dois proposer un mot de #{mot_a_trouver.size} lettres"
    return false
  end

  if mot_propose[0] != mot_a_trouver[0]
    puts "Tu dois proposer un mot qui commence par la lettre #{mot_a_trouver[0]}"
    return false
  end

  unless mots_proposables.include?(mot_propose)
    puts "Le mot #{mot_propose} n'est pas dans le dictionnaire"
    return false
  end

  true
end

def afficher(propositions)
  propositions.each do |proposition, code_resultat|
    puts "   #{proposition.chars.join(" ")}"
    puts "   #{code_resultat}"
  end
end

def resultat_code(proposition, le_mot, bien_placees)
  code_resultat = Array.new(proposition.size) { "🟦" }
  lettres_du_mot = le_mot.chars

  proposition.each_char.with_index do |lettre, idx|
    if lettre == lettres_du_mot[idx]
      code_resultat[idx] = "🟥"
      lettres_du_mot[idx] = "#"

      bien_placees[idx] = lettre if bien_placees[idx] == "."
    end
  end

  proposition.each_char.with_index do |lettre, idx|
    next if code_resultat[idx] == "🟥"

    if lettres_du_mot.include?(lettre)
      code_resultat[idx] = "🟡"
      lettres_du_mot[lettres_du_mot.index(lettre)] = "#"
    end
  end

  code_resultat.join
end

def ligne_tableau_sutom(jour, mot, propositions_h, resultats_bots)
  meilleur_bot = resultats_bots.min
  essais_h = propositions_h.size

  emoji = "🤖" if meilleur_bot < essais_h
  emoji = "🕊️" if meilleur_bot == essais_h
  emoji = "💪" if meilleur_bot > essais_h

  "\n| #{format("%03d", jour)}<br>(*Twitch*) | #{emoji} | <span title=\"#{mot}\">*caché*</span> | #{propositions_h.values.join("<br>")} | #{resultats_bots.join(" | ")} |"
end

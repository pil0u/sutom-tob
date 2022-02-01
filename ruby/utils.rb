def initialiser_dictionnaire(liste_mots)
  dict = {}

  liste_mots.each do |mot|
    taille = mot.length
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

def valide?(mot_propose, mot_a_trouver, mots_proposables)  
  if mot_propose.length != mot_a_trouver.length
    puts "Tu dois proposer un mot de #{mot_a_trouver.length} lettres"
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

  return true
end

def afficher(propositions)
  propositions.each do |proposition, code_resultat|
    puts "   #{proposition.chars.join(" ")}"
    puts "   #{code_resultat.join}"
  end
end

require_relative "utils"

def player_run(le_mot, les_mots_proposables)
  taille_du_mot = le_mot.size
  debut_du_mot = le_mot[0]
  puts "Mot à trouver: #{debut_du_mot + '*' * (taille_du_mot - 1)} (#{taille_du_mot} lettres)\n"

  bien_placees = [debut_du_mot] + ['.'] * (taille_du_mot - 1)

  propositions = {}

  while true
    # Récapitulatif des informations connues
    puts "\n   #{bien_placees.join}"

    # Demande du mot
    print "##{propositions.size + 1} "
    proposition = gets.chomp.upcase

    # Possibilité de quitter à tout moment en tapant "q"
    if proposition == "Q"
      puts "Le mot était #{le_mot}"
      return
    end

    # La proposition est-elle valide ?
    if propositions.has_key?(proposition)
      puts "Tu as déjà proposé le mot #{proposition} 🙃"
      next
    end
    
    unless valide?(proposition, les_mots_proposables, le_mot)
      afficher(propositions)
      next
    end

    # Construction du résultat codé
    code = resultat_code(proposition, le_mot, bien_placees)

    # Ajout de la proposition à la liste et affichage du résultat
    propositions[proposition] = code
    afficher(propositions)

    # Mise à jour du statut du jeu
    break if le_mot == proposition
  end

  puts "Bravo ! Tu as trouvé #{le_mot} en #{propositions.size} tentatives."

  propositions
end

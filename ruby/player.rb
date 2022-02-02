require_relative "utils"

def player_run(le_mot, le_dictionnaire)
  taille_du_mot = le_mot.length
  debut_du_mot = le_mot[0]
  puts "Mot à trouver: #{debut_du_mot + '*' * (taille_du_mot - 1)}\n"

  mots_proposables = le_dictionnaire[taille_du_mot][debut_du_mot]
  propositions = {}

  bien_placees = [debut_du_mot] + ['.'] * (taille_du_mot - 1)
  mot_trouve = false
  essai = 1

  until mot_trouve
    # Récapitulatif des informations connues
    puts "\n   #{bien_placees.join}"

    # Demande du mot
    print "##{essai} "
    proposition = gets.chomp.upcase

    # Possibilité de quitter à tout moment en tapant "q"
    if proposition == "Q"
      puts "Le mot était #{le_mot}"
      return
    end
    
    # La proposition est-elle valide ?
    unless valide?(proposition, mots_proposables, le_mot)
      afficher(propositions)
      next
    end

    # Construction du résultat codé
    code = resultat_code(proposition, le_mot, bien_placees)

    # Ajout de la proposition à la liste et affichage du résultat
    propositions[proposition] = code
    afficher(propositions)

    # Mise à jour du statut du jeu
    mot_trouve = le_mot == proposition
    essai += 1 unless mot_trouve
  end

  puts "Bravo ! Tu as trouvé #{le_mot} en #{essai} tentatives."
end

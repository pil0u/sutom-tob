require "byebug"
require "set"
require_relative "config"
require_relative "robot"
require_relative "utils"

# Chargement du dictionnaire
mots = File.readlines("data/mots.txt", chomp: true)
dictionnaire = initialiser_dictionnaire(mots)

# Tirage du mot
le_mot = mots.sample

taille_du_mot = le_mot.length
debut_du_mot = le_mot[0]
puts "Mot à trouver: #{AFFICHER_LE_MOT ? le_mot : '*' * taille_du_mot}\n"

mots_proposables = dictionnaire[taille_du_mot][debut_du_mot]

# Initialisation du jeu
propositions = {}
mot_trouve = false
essai = 1

emplacements = [Set[debut_du_mot]] + [Set[*("A".."Z")]] * (taille_du_mot - 1)
bien_placees = [debut_du_mot] + ['.'] * (taille_du_mot - 1)
contenues = [debut_du_mot]
absentes = Set.new

# Début du jeu
until mot_trouve
  p emplacements

  puts "   Le mot ne contient pas : #{absentes.sort.join(", ")}" unless absentes.empty?
  puts "   Le mot contient :        #{contenues.join(", ")}" unless contenues.empty?
  puts ""
  puts "   #{bien_placees.join}"

  if PROPOSITION_AUTO
    proposition = robot(propositions, mots_proposables, bien_placees, contenues, absentes, emplacements)
  else
    print "##{essai} "
    proposition = gets.chomp.upcase
  end

  if proposition == "Q"
    puts "Le mot était #{le_mot}"
    return
  end

  mot_trouve = le_mot == proposition

  unless valide?(proposition, le_mot, mots_proposables)
    afficher(propositions)
    next
  end

  # if propositions.has_key?(proposition)
  #   puts "Tu as déjà proposé #{proposition}"
  #   next
  # end

  # Traitement des résultats pour stockage et affichage
  lettres_du_mot = le_mot.chars

  code_resultat = []
  bien_placees_courantes = []
  mal_placees_courantes = []
  absentes_courantes = Set.new

  proposition.each_char.with_index do |lettre, idx|

    if lettre == lettres_du_mot[idx]
      code_resultat << "🟥"
      lettres_du_mot[idx] = "#"
      bien_placees_courantes << lettre

      bien_placees[idx] = lettre if bien_placees[idx] == "."
      emplacements[idx] = Set[lettre] if emplacements[idx].size > 1
    elsif lettres_du_mot.include?(lettre)
      code_resultat << "🟡"
      lettres_du_mot[lettres_du_mot.index(lettre)] = "#"
      mal_placees_courantes << lettre
    else
      code_resultat << "🟦"
      absentes_courantes.add(lettre)
    end
  end

  # Objectif : lister les lettres contenues dans le mot (exemple : GARAGE)
  # 
  #                 bien_placees    mal_placees_     bien_placees
  # proposition  |  _courantes   |  courantes     |  (globales)    |  contenues
  #      -       |       -       |        -       |  G             |  G
  # GRIFFE       |  G . . . . E  |  . R . . . .   |  G . . . . E   |  G, R, E
  # GAGNER       |  G A . . . .  |  . . G . E R   |  G A . . . E   |  G, A, G, E, R
  #
  # Pour une proposition donnée, l'objectif est donc de trouver les valeurs "contenues".
  # En résonnant avec des ensembles, la formule magique serait la suivante :
  #   contenues_new = bien_placees + ((contenues_old - bien_placees) U (mal_placees_courantes - (bien_placees - bien_placees_courantes)))

  # (bien_placees - bien_placees_courantes)
  bien_placees_manquantes = bien_placees.select { |l| l != "." }
  bien_placees_courantes.each do |l|
    bien_placees_manquantes.delete_at(bien_placees_manquantes.index(l) || bien_placees_manquantes.length)
  end

  # (mal_placees_courantes - (bien_placees - bien_placees_courantes))
  bien_placees_manquantes.each do |l|
    mal_placees_courantes.delete_at(mal_placees_courantes.index(l) || mal_placees_courantes.length)
  end

  # (contenues - bien_placees)
  bien_placees.each do |l|
    contenues.delete_at(contenues.index(l) || contenues.length)
  end

  # ((contenues - bien_placees) U (mal_placees_courantes - (bien_placees - bien_placees_courantes)))
  restantes = contenues.tally
    .merge(mal_placees_courantes.tally) { |k, v1, v2| [v1, v2].max }
    .map { |k, v| [k] * v }
    .flatten

  # contenues_new
  contenues = (bien_placees.select { |l| l != "." } + restantes).sort

  # Mise à jour des lettres absentes
  absentes_courantes.each do |lettre|
    absentes.add(lettre) unless contenues.include?(lettre)
  end

  propositions[proposition] = code_resultat
  afficher(propositions)

  essai += 1 unless mot_trouve
end

puts "Bravo ! Tu as trouvé #{le_mot} en #{essai} tentatives."

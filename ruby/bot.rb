# frozen_string_literal: true

require 'set'
require_relative 'utils'

def bot_run(le_mot, les_mots_proposables, la_matrice, le_bot, limite = nil)
  idx_du_mot = les_mots_proposables.index(le_mot)
  taille_du_mot = le_mot.size
  debut_du_mot = le_mot[0]

  positions = [Set[debut_du_mot]] + Array.new(taille_du_mot - 1) { Set[*('A'..'Z')] }
  compteur = { debut_du_mot => 1 }
  compteur_exact = Set.new

  propositions = {}

  loop do
    proposition = le_bot.call(les_mots_proposables, propositions, positions, compteur, compteur_exact)

    if le_mot == proposition
      propositions[proposition] = '🟥' * taille_du_mot
      break
    end

    idx_proposition = les_mots_proposables.index(proposition)
    trinaire_decimal = la_matrice[idx_du_mot][idx_proposition]
    trinaire = trinaire_pur(trinaire_decimal, taille_du_mot)

    tmp_compteur = Hash.new(0)

    trinaire.each_with_index do |code, idx|
      lettre = proposition[idx]

      case code
      when 2
        positions[idx] = Set[lettre] if positions[idx].size > 1
        tmp_compteur[lettre] += 1
      when 1
        positions[idx].delete(lettre)
        tmp_compteur[lettre] += 1
      when 0
        positions[idx].delete(lettre)
        tmp_compteur[lettre] += 0
        compteur_exact.add(lettre)
      end
    end

    compteur = compteur.merge(tmp_compteur) { |_k, v1, v2| [v1, v2].max }
    propositions[proposition] = codage(trinaire)

    break if limite && propositions.size == limite
  end

  propositions
end

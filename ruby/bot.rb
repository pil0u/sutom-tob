# frozen_string_literal: true

require 'set'
require_relative 'utils'

def bot_run(le_mot, les_mots_proposables, le_bot, limite = nil)
  taille_du_mot = le_mot.size
  debut_du_mot = le_mot[0]

  positions = [Set[debut_du_mot]] + Array.new(taille_du_mot - 1) { Set[*('A'..'Z')] }
  compteur = { debut_du_mot => 1 }
  compteur_exact = Set.new

  propositions = {}
  essais = 1

  loop do
    proposition = le_bot.call(les_mots_proposables, propositions, positions, compteur, compteur_exact)

    if le_mot == proposition
      propositions[proposition] = '🟥' * taille_du_mot
      break
    end

    # Mise à jour des informations et codage du résultat
    # OPTIM : enlever le codage du résultat (inutile en benchmark)
    code = Array.new(proposition.size) { '🟦' }
    lettres_du_mot = le_mot.chars
    tmp_compteur = Hash.new(0)

    # 1ère passe sur toutes les lettres pour trouver les bien placées
    indices_restants = []

    proposition.each_char.with_index do |lettre, idx|
      if lettre == lettres_du_mot[idx]
        code[idx] = '🟥'
        lettres_du_mot[idx] = '#'

        positions[idx] = Set[lettre] if positions[idx].size > 1
        tmp_compteur[lettre] += 1
      else
        indices_restants << idx
      end
    end

    # 2ème passe sur les lettres autres que bien placées
    indices_restants.each do |idx|
      lettre = proposition[idx]

      if lettres_du_mot.include?(lettre)
        code[idx] = '🟡'
        lettres_du_mot[lettres_du_mot.index(lettre)] = '#'

        positions[idx].delete(lettre)
        tmp_compteur[lettre] += 1
      else
        code[idx] = '🟦'

        positions[idx].delete(lettre)
        tmp_compteur[lettre] += 0
        compteur_exact.add(lettre)
      end
    end

    propositions[proposition] = code.join
    compteur = compteur.merge(tmp_compteur) { |_k, v1, v2| [v1, v2].max }

    essais += 1
    break if limite && essais == limite
  end

  [propositions, essais]
end

require "set"

require_relative "bots/v0"
require_relative "bots/v1"
require_relative "utils"

def bot_run(la_version, le_mot, le_dictionnaire)
  case la_version
  when 0
    bot = method(:bot_v0)
  when 1
    bot = method(:bot_v1)
  else
    puts "Cette version du bot n'existe pas."
    return
  end

  taille_du_mot = le_mot.length
  debut_du_mot = le_mot[0]

  mots_proposables = le_dictionnaire[taille_du_mot][debut_du_mot]
  propositions = {}

  emplacements = [Set[debut_du_mot]]
  (taille_du_mot - 1).times { emplacements << Set[*("A".."Z")].clone }
  infos = { debut_du_mot => 1 }

  essais = 1

  while true
    proposition = bot.call(mots_proposables, propositions, emplacements, infos)

    if le_mot == proposition
      propositions[proposition] = ["🟥"] * taille_du_mot
      break
    end

    # Mise à jour des informations et codage du résultat
    code = []
    lettres_du_mot = le_mot.chars
    infos_proposition = {}

    proposition.each_char.with_index do |lettre, idx|
      if lettre == lettres_du_mot[idx]
        code << "🟥"
        lettres_du_mot[idx] = "#"

        emplacements[idx] = Set[lettre] # OPTIM: if emplacements[idx].size > 1
        infos_proposition[lettre] = infos_proposition.has_key?(lettre) ? infos_proposition[lettre] + 1 : 1
      elsif lettres_du_mot.include?(lettre)
        code << "🟡"
        lettres_du_mot[lettres_du_mot.index(lettre)] = "#"

        emplacements[idx].delete(lettre)
        infos_proposition[lettre] = infos_proposition.has_key?(lettre) ? infos_proposition[lettre] + 1 : 1
      else
        code << "🟦"

        if infos_proposition.has_key?(lettre)
          emplacements[idx].delete(lettre)
        else
          emplacements.each do |e|
            e.delete(lettre)
          end
          infos_proposition[lettre] = 0
        end
      end
    end

    propositions[proposition] = code
    infos = infos.merge(infos_proposition) { |k, v1, v2| [v1, v2].max }
    essais += 1
  end

  [propositions, essais]
end

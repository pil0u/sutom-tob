# frozen_string_literal: true

def bot_v0(mots_proposables,
           propositions,
           _positions,
           _compteur,
           _compteur_exact)

  (mots_proposables - propositions.keys).first
end

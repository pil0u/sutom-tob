# frozen_string_literal: true

require 'csv'
require 'tzinfo'

class Sutom
  def initialize
    @chemin_resultats_robots = CHEMIN_RESULTATS_ROBOTS
    @chemin_resultats_humains = CHEMIN_RESULTATS_HUMAINS
    @derniere_version_bot = DERNIERE_VERSION_BOT
  end

  def construire_readme
    resultats_robots = mise_a_jour_robots
    resultats_humains = lire_resultats_humains

    jours_markdown = []
    agg_scores = Hash.new(0)

    resultats_robots.each do |jour, infos_r|
      infos_h = resultats_humains[jour]

      jour_str = "#{format('%03d', jour)}#{'<br>(*Twitch*)' if infos_h&.dig(:twitch)}"

      if infos_h.nil?
        emoji = '❓'
        mot_str = '*À résoudre*'
        solution_str = '**À résoudre**'
        scores_robots = infos_r[:scores].join(' | ')

      else
        meilleur_score = infos_r[:scores].min
        emoji = '🤖' if meilleur_score < infos_h[:score]
        emoji = '🕊️' if meilleur_score == infos_h[:score]
        emoji = '💪' if meilleur_score > infos_h[:score]

        mot_str = "<span title=\"#{infos_r[:mot]}\">*caché*</span>"
        solution_str = infos_h[:solution].join('<br>')
        scores_robots = infos_r[:scores].map do |s|
          s < infos_h[:score] && s == meilleur_score ? "**#{s}\\***" : s.to_s
        end
      end

      jours_markdown << "| #{[jour_str, emoji, mot_str, solution_str, scores_robots].join(' | ')} |"
      agg_scores[emoji] += 1
    end

    [jours_markdown, agg_scores]
  end

  private

  def lire_resultats_humains
    File.readlines(@chemin_resultats_humains, chomp: true)
        .slice_after('')
        .to_h do |a|
          [
            a[0].to_i,
            { score: a[1..-2].count, twitch: a[0].split[1] == 'Twitch', solution: a[1..-2] }
          ]
        end
  end

  def mise_a_jour_robots
    existant = lire_resultats_robots
    total_jours = dernier_jour

    resultats = {}

    (1..total_jours).each do |jour|
      la_ligne = existant[jour]

      # Si toute la ligne est déjà remplie, on passe à la suivante
      if la_ligne.is_a?(Hash) && la_ligne[:scores].all?(&:nonzero?)
        resultats[jour] = la_ligne
        next
      end

      # Sinon, on refait tout
      puts "Mise à jour (#{jour})"

      mot = mot_sutom(jour)
      mots_proposables = File.readlines("data/#{mot.size}#{mot[0]}/liste.txt", chomp: true)
      matrice = JSON.load_file("data/#{mot.size}#{mot[0]}/matrice.json")

      scores = []

      (1..@derniere_version_bot).each do |version|
        bot_name = "bot_v#{version}".to_sym
        propositions = bot_run(mot, mots_proposables, matrice, method(bot_name))

        scores << propositions.size
      end

      resultats[jour] = { mot:, scores: }
    end

    ecrire_resultats_robots(resultats)

    resultats
  end

  def dernier_jour
    origine = Date.new(2022, 1, 7)
    now = TZInfo::Timezone.get('Europe/Paris').now.to_date

    (now - origine).to_i
  end

  def lire_resultats_robots
    csv = CSV.parse(
      File.read(@chemin_resultats_robots),
      headers: true,
      header_converters: :symbol
    )

    csv = csv.map do |row|
      scores = row[2..].map(&:to_i)

      [row[:jour].to_i, { mot: row[:mot], scores: }]
    end

    csv.to_h
  end

  def ecrire_resultats_robots(resultats)
    bot_names = (1..@derniere_version_bot).map { |i| "bot_v#{i}".to_sym }
    headers = %i[jour mot] + bot_names

    CSV.open(@chemin_resultats_robots, 'w') do |csv|
      csv << headers

      resultats.each do |jour, misc|
        csv << ([jour, misc[:mot]] + misc[:scores])
      end
    end
  end
end

require "json"
require_relative "../utils"

(6..9).each do |n|
  %w(A B C D E F G H I J L M N O P R S T U V).each do |l|
    niveau = "#{n}#{l}"

    liste = File.readlines("data/#{n}#{l}/liste.txt", chomp: true)
    matrice = JSON.load_file("data/#{n}#{l}/matrice.json")

    taille = liste.size.to_f
    compteurs = {}

    matrice.each_with_index do |row, i|
      row.each_with_index do |value, j|
        proposition = liste[j]

        compteurs[proposition] ||= Hash.new(0)
        compteurs[proposition][value] += 1
      end
    end

    entropies = compteurs
                  .map { |mot, h| [mot, h.map { |_, compte| compte/taille }.sum { |i| i * Math.log2(1/i) }] }
                  .sort_by { |_, e| -e }
                  .to_h

    File.open("data/#{niveau}/entropies.json", "w") do |f|
      JSON.dump(entropies, f)
    end

    puts "#{niveau} - done!"
  end
end

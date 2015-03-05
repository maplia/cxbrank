require 'csv'

CSV.read('db/fixtures/musics.csv').each do |line|
  Music.seed(:id) do |s|
    s.id = line[0]
    s.number = line[1]
    s.text_id = line[2]
    s.title = line[3]
    s.subtitle = line[4]
    s.sortkey = line[5]
    s.difficulty1_level = line[6]
    s.difficulty2_level = line[7]
    s.difficulty3_level = line[8]
    s.difficulty1_notes = line[9]
    s.difficulty2_notes = line[10]
    s.difficulty3_notes = line[11]
    s.added_at = line[12].empty? ? '2013-12-02 04:00' : line[12]
  end
end

CSV.read('db/fixtures/bonus_musics.csv').each do |line|
  BonusMusic.seed(:music_id, :period_start) do |s|
    s.music_id = Music.where('text_id = ?', line[0]).first.id
    s.period_start = line[1]
    s.period_end = line[2]
  end
end

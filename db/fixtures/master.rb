require 'csv'

CSV.read('db/fixtures/musics.csv').each do |line|
  Music.seed(:id) do |s|
    s.id = line[0]
    s.number = line[1]
    s.text_id = line[2]
    s.title = line[3]
    s.subtitle = line[4]
    s.sortkey = line[5]
    s.added_at = line[6] || '2013-12-02 04:00'
  end
end

CSV.read('db/fixtures/music_scores.csv').each do |line|
  MusicScore.seed(:id) do |s|
    s.music_id = Music.where('text_id = ?', line[0]).first.id
    s.difficulty = line[1]
    s.level = line[2]
    s.notes = line[3]
  end
end

CSV.read('db/fixtures/bonus_musics.csv').each do |line|
  BonusMusic.seed(:music_id, :period_start) do |s|
    s.music_id = Music.where('text_id = ?', line[0]).first.id
    s.period_start = line[1]
    s.period_end = line[2]
  end
end

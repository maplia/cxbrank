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

BonusMusic.seed(:music_id, :period_start,
  {
    music_id: Music.where('text_id = ?', 'wannabeyourspecial').first.id,
    period_start: '2013-12-02 04:00', period_end: '2013-12-27 15:00',
  },
  {
    music_id: Music.where('text_id = ?', 'touchofgold').first.id,
    period_start: '2013-12-02 04:00', period_end: '2013-12-27 15:00',
  },
  {
    music_id: Music.where('text_id = ?', 'amenootoganijiwoyobu').first.id,
    period_start: '2013-12-02 04:00', period_end: '2013-12-27 15:00',
  },
  {
    music_id: Music.where('text_id = ?', 'landingonthemoon').first.id,
    period_start: '2013-12-27 15:00', period_end: '9999-12-31 23:59',
  },
  {
    music_id: Music.where('text_id = ?', 'kimitomusic').first.id,
    period_start: '2013-12-27 15:00', period_end: '9999-12-31 23:59',
  },
  {
    music_id: Music.where('text_id = ?', 'dirtymouth').first.id,
    period_start: '2013-12-27 15:00', period_end: '9999-12-31 23:59',
  },
)

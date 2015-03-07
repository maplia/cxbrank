APP_INFO = {
  name: 'CxB RankPoint Simulator', version: '1.0.0'
}

LIST_BLOCKS = {
  bonus: {
    id: 'bonus', title: '期間限定RP対象曲', target_count: -1,
  },
  regular: {
    id: 'regular', title: '一般曲', target_count: 20,
  },
}

DIFFICULTIES = {
  difficulty1: {
    id: 1, text: 'STANDARD',  abbr: 'STD', img_src: 'standard.png', css_class: 'standard',
  },
  difficulty2: {
    id: 2, text: 'HARD',      abbr: 'HRD', img_src: 'hard.png',     css_class: 'hard',
  },
  difficulty3: {
    id: 3, text: 'MASTER',    abbr: 'MAS', img_src: 'master.png',   css_class: 'master',
  },
=begin
  difficulty4: {
    id: 4, text: 'EASY',      abbr: 'ESY', css_class: 'easy',
  },
  difficulty5: {
    id: 5, text: 'UNLIMITED', abbr: 'UNL', css_class: 'unlimited',
  },
=end
}

PLAY_STATUSES = {
  noplay: {
    value: 0, text: 'プレイなし',
  },
  failed: {
    value: 1, text: 'クリア失敗',
  },
  cleared: {
    value: 2, text: 'クリア',
  },
}

GRADE_STATUSES = {
  grade0: {
    value:  0, text: '',
  },
  grade1: {
    value:  1, text: 'S++',
  },
  grade2: {
    value:  2, text: 'S+',
  },
  grade3: {
    value:  3, text: 'S',
  },
  grade4: {
    value:  4, text: 'A+',
  },
  grade5: {
    value:  5, text: 'A',
  },
  grade6: {
    value:  6, text: 'B+',
  },
  grade7: {
    value:  7, text: 'B',
  },
  grade8: {
    value:  8, text: 'C',
  },
  grade9: {
    value:  9, text: 'D',
  },
  grade10: {
    value: 10, text: 'E',
  },
}

COMBO_STATUSES = {
  combo0: {
    value: 0, text: '',
  },
  combo1: {
    value: 1, text: 'FC',
  },
  combo2: {
    value: 2, text: 'EXC',
  },
}

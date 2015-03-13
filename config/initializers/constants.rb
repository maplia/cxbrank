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

BORDER_GRADES = {
  gradeSPP: {
      id: 1, text: 'S++', upper: 100, lower: 100,
  },
  gradeSP: {
      id: 2, text: 'S+', upper: 100, lower: 98,
  },
  gradeS: {
      id: 3, text: 'S', upper: 98, lower: 95,
  },
  gradeAP: {
      id: 4, text: 'A+', upper: 95, lower: 90,
  },
  gradeA: {
      id: 5, text: 'A', upper: 90, lower: 85,
  },
=begin
  gradeBP: {
      id: 6, text: 'B+', upper: 85, lower: 80,
  },
  gradeB: {
      id: 7, text: 'B', upper: 80, lower: 75,
  },
  gradeC: {
      id: 8, text: 'C', upper: 75, lower: 70,
  },
  gradeD: {
      id: 9, text: 'D', upper: 70, lower: 65,
  },
  gradeE: {
      id: 10, text: 'E', upper: 65, lower: 0,
  },
=end
}

BORDER_CLEARRATES = [
    99, 98, 97, 96, 95
]

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

GRADE_STATUSES = [
  ['',     0],
  ['S++',  1],
  ['S+',   2],
  ['S',    3],
  ['A+',   4],
  ['A',    5],
  ['B+',   6],
  ['B',    7],
  ['C',    8],
  ['D',    9],
  ['E',   10],
]

COMBO_STATUSES = [
  ['',    0],
  ['FC',  1],
  ['EXC', 2],
]

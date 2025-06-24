module.exports = {
  testMatch: ['**/*.spec.js'], // Sadece .spec.js dosyalarını test et
  collectCoverage: true,       // Kapsama raporu toplansın
  collectCoverageFrom: [       // Kapsama raporuna dahil edilecek tüm js dosyaları
    '!index.js',               // CLI Tarafından çağırıldığı için birim test kapsama raporunda hep %0 çıkacak, bu sepeble ihmal ediyoruz
    'src/**/*.js',
    '!**/*.spec.js',           // Test dosyaları kapsama dışında tutulabilir
    '!node_modules/**',
    "!coverage/**",
  ],
  coverageReporters: ['text', 'lcov'], // Rapor formatları
};

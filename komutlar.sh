 mkdir -p hesap-makinesi/{src,__tests__}
 cd hesap-makinesi
 # node geliştirme başlasın
 npm init -y
 # git başlasın
 git config --global user.email "cem.topkaya@telenity.com"
 git config --global user.name "Cem Topkaya"
 git config --global init.defaultBranch master
 git init
# .gitignore dosyası oluşturma
cat > .gitignore << 'EOF'
coverage/
node_modules/
*.log
*.diff
coverage/
EOF

git add .
git commit -m "project and git initialized"
# herşey oldu mu kontrol edelim
git status 
git ls-files
# .gitignore dosyası oluşturma
cat > index.js << 'EOF'
console.log("Huzurlarınızda 1.0.0 sürümü")
EOF

# package.json güncelleme
# "star": "node index.js"
cat > package.json << 'EOF'
{
  "name": "hesap-makinesi",
  "version": "0.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
EOF

git add .
git commit -m "Initial commit"
echo ">>>>>>>>----------------------"
jq .version package.json
npm version major -m "Version 1.0.0"
jq .version package.json
echo "-------------------<<<<<<<<<<<"
git tag -l --sort=creatordate
# Yeni dal oluştur
git checkout -b future/PRJ-1
echo ">>>>>>>>----------------------"
jq .version package.json
npm version preminor --preid=SNAPSHOT -m "PRJ-1 için kodlamaya başlandı. v1.1.0-SNAPSHOT.0"
jq .version package.json
echo "-------------------<<<<<<<<<<<"
# Toplama modülü
cat > src/toplama.js << 'EOF'
function topla(a, b) {
  return a + b;
}

module.exports = { topla };
EOF

# Ana uygulama dosyası
cat > index.js << 'EOF'
const { topla } = require("./src/toplama");

if (process.argv.length < 4) {
  console.log("Lütfen iki sayı giriniz");
  process.exit(1);
}

const arg1 = process.argv[2];
const arg2 = process.argv[3];

const sonuc = topla(arg1, arg2);
console.log(`Sonuç: ${sonuc}`);
EOF

# package.json güncelleme
# "test": "jest --collect-coverage"
cat > package.json << 'EOF'
{
  "name": "hesap-makinesi",
  "version": "1.1.0-SNAPSHOT.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "jest --collect-coverage"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
EOF

npm install --save-dev jest
cat > jest.config.js << 'EOF'
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
EOF

# Toplama testleri
cat > __tests__/toplama.spec.js << 'EOF'
const { topla } = require("../src/toplama");

describe("Toplama Fonksiyonu", () => {
  test("İki sayıyı doğru toplar", () => {
    expect(topla(2, 3)).toBe(5);
  });
});
EOF

npm test
# Ana uygulama dosyası
cat > index.js << 'EOF'
const { topla } = require("./src/toplama");

if (process.argv.length < 4) {
  console.log("Lütfen iki sayı giriniz");
  process.exit(1);
}

const sayi1 = parseFloat(process.argv[2]);
const sayi2 = parseFloat(process.argv[3]);

const sonuc = topla(sayi1, sayi2);
console.log(`Sonuç: ${sonuc}`);
EOF

npm test
git add .
git commit -m "PRJ-1: Addition feature completed"
echo ">>>>>>>>----------------------"
jq .version package.json
npm version minor -m "Version 1.1.0"
jq .version package.json
echo "-------------------<<<<<<<<<<<"
git checkout master
git merge  --no-ff future/PRJ-1  -m "Merge branch 'future/PRJ-1' into master"



# ------------- 1.1.0 sürümünden sonra
# Bir yama gelecek ve sürüm 1.1.1 olacak

 git checkout -b bugfix/PRJ-2
 echo ">>>>>>>>----------------------"
 jq .version package.json
 npm version prepatch --preid=SNAPSHOT -m "PRJ-2: Start 1.1.1-SNAPSHOT.0"
 jq .version package.json
 echo "-------------------<<<<<<<<<<<"
 cat > ./src/toplama.js << 'EOF'
function topla(a, b) {

  if (isNaN(a)) {
    console.log("İlk argüman sayı değil");
    return NaN;
  }

  if (isNaN(b)) {
    console.log("İkinci argüman sayı değil");
    return NaN;
  }

  return a + b;
}

module.exports = { topla };
EOF

 cat > ./__tests__/toplama.spec.js << 'EOF'
const { topla } = require("../src/toplama");

describe("Toplama Fonksiyonu", () => {
  test("İki sayıyı doğru toplar", () => {
    expect(topla(2, 3)).toBe(5);
  });

  test("Sadece a sayısı NaN ise uyarı verir ve sonuç NaN olur", () => {
    const consoleSpy = jest.spyOn(console, "log").mockImplementation(() => {});
    expect(topla("abc", 5)).toBeNaN();
    expect(topla("abc", "xyz")).toBeNaN(); // b de NaN olsa da sadece a kontrol ediliyor
    expect(topla(NaN, 10)).toBeNaN();
    expect(topla(undefined, 7)).toBeNaN();
    expect(topla(null, 7)).not.toBeNaN(); // null sayısal olarak 0 kabul edilir
    expect(consoleSpy).toHaveBeenCalledWith("İlk argüman sayı değil");
    consoleSpy.mockRestore();
  });

});
EOF

git add .
git commit -m "PRJ-2: Add number validation"
echo ">>>>>>>>----------------------"
jq .version package.json
npm version prerelease -m "PRJ-2: Update to 1.1.1-SNAPSHOT.1"
jq .version package.json
echo "-------------------<<<<<<<<<<<"
npm test


echo ">>>>>>>>----------------------"
jq .version package.json
npm version patch -m "PRJ-2: Version 1.1.1"
jq .version package.json
echo "-------------------<<<<<<<<<<<"

# Main'e merge
git checkout master
git merge  --no-ff bugfix/PRJ-2  -m "Merge branch 'bugfic/PRJ-2' into master"

# --------------- 1.2.0 Sürümüne geçiş

git checkout -b feature/PRJ-3
npm version preminor --preid=SNAPSHOT -m "Start 1.2.0-SNAPSHOT.0"
# Çıkarma modülü
cat > ./src/cikarma.js << 'EOF'
function cikar(a, b) {
  return a - b;
}

module.exports = { cikar };
EOF

# Uygulama güncellemesi
cat > index.js << 'EOF'
const { topla } = require("./src/toplama");
const { cikar } = require("./src/cikarma");

if (process.argv.length < 5) {
  console.log("Lütfen iki sayı ve işlem türünü giriniz");
  process.exit(1);
}

const sayi1 = parseFloat(process.argv[2]);
const sayi2 = parseFloat(process.argv[3]);
const islem = process.argv[4]

let sonuc;
if (islem === "topla") {
  sonuc = topla(sayi1, sayi2);
} else if (islem === "cikar") {
  sonuc = cikar(sayi1, sayi2);
} else {
  console.log("Geçersiz işlem. 'topla' veya 'cikar' kullanın");
  process.exit(1);
}

console.log(`Sonuç: ${sonuc}`);
EOF

git add .
git commit -m "PRJ-3: Add subtraction feature"
npm version prerelease -m "Update to 1.2.0-SNAPSHOT.1"
# Çıkarma testleri
cat > __tests__/cikarma.spec.js << 'EOF'
const { cikar } = require("../src/cikarma");

describe("Çıkarma Fonksiyonu", () => {
  test("İki sayıyı doğru çıkarır", () => {
    expect(cikar(5, 3)).toBe(2);
  });
});
EOF

git add .
git commit -m "PRJ-3: Add subtraction tests"
npm version prerelease -m "Update to 1.2.0-SNAPSHOT.2"
npm test
git tag -l --sort=creatordate
diff-cover --diff-file <(git diff v1.1.1..HEAD) --fail-under 100 coverage/lcov.info
npm version minor -m "PRJ-3: Version 1.2.0"
# Main'e merge
git checkout master
git merge  --no-ff feature/PRJ-3 -m "Merge branch 'future/PRJ-3' into master"
# git branch -d feature/PRJ-3
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

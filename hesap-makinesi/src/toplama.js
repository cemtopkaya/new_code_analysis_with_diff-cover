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

const { cikar } = require("../src/cikarma");

describe("Çıkarma Fonksiyonu", () => {
  test("İki sayıyı doğru çıkarır", () => {
    expect(cikar(5, 3)).toBe(2);
  });
});

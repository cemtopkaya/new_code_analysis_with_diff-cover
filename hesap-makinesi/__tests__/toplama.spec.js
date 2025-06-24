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

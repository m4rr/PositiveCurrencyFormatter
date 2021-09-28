import XCTest
@testable import PositiveCurrencyFormatter

private let nbsp = " ",
            positiveSign = "+", negativeSign = "−",
            ltrMark = "\u{200e}", rtlMark = "\u{200f}", u061c = "\u{061c}",
            AED = "د.إ.", ILS = "₪"

final class PositiveCurrencyFormatterTests: XCTestCase {

  func test_zeroes() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "nl_NL"))

    XCTAssertEqual(nf.string(from: -0.01)!, "€\(nbsp)−0,01")
    XCTAssertEqual(nf.string(from:  0.01)!, "€\(nbsp)+0,01")

    XCTAssertEqual(nf.string(from: -0)!, "€\(nbsp)0,00")
    XCTAssertEqual(nf.string(from:  0)!, "€\(nbsp)0,00")
  }

  func test_nl_NL_EUR_nil() {
    let nf1 = PositiveCurrencyFormatter(locale: Locale(identifier: "nl_NL"), currencyCode: "EUR", currencySymbol: "€")
    let nf2 = PositiveCurrencyFormatter(locale: Locale(identifier: "nl_NL"), currencyCode: nil, currencySymbol: nil)
    let nf3 = PositiveCurrencyFormatter(locale: Locale(identifier: "nl_NL"))

    XCTAssertEqual(nf1.string(from: -123.65)!, "€\(nbsp)−123,65")
    XCTAssertEqual(nf1.string(from:  123.65)!, "€\(nbsp)+123,65")

    XCTAssertEqual(nf2.string(from: -123.65)!, "€\(nbsp)−123,65")
    XCTAssertEqual(nf2.string(from:  123.65)!, "€\(nbsp)+123,65")

    XCTAssertEqual(nf3.string(from: -123.65)!, "€\(nbsp)−123,65")
    XCTAssertEqual(nf3.string(from:  123.65)!, "€\(nbsp)+123,65")

    XCTAssertEqual(nf1.string(from: -123.65)!, nf2.string(from: -123.65)!, nf3.string(from: -123.65)!)
    XCTAssertEqual(nf1.string(from:  123.65)!, nf2.string(from:  123.65)!, nf3.string(from:  123.65)!)
  }

  func test_en_US_USD_nil() {
    let nf1 = PositiveCurrencyFormatter(locale: Locale(identifier: "en_US"), currencyCode: "USD", currencySymbol: "$")
    let nf2 = PositiveCurrencyFormatter(locale: Locale(identifier: "en_US"), currencyCode: nil, currencySymbol: nil)
    let nf3 = PositiveCurrencyFormatter(locale: Locale(identifier: "en_US"))

    XCTAssertEqual(nf1.string(from: -123.65)!, "−$123.65")
    XCTAssertEqual(nf1.string(from:  123.65)!, "+$123.65")

    XCTAssertEqual(nf2.string(from: -123.65)!, "−$123.65")
    XCTAssertEqual(nf2.string(from:  123.65)!, "+$123.65")

    XCTAssertEqual(nf3.string(from: -123.65)!, "−$123.65")
    XCTAssertEqual(nf3.string(from:  123.65)!, "+$123.65")

    XCTAssertEqual(nf1.string(from: -123.65)!, nf2.string(from: -123.65)!, nf3.string(from: -123.65)!)
    XCTAssertEqual(nf1.string(from:  123.65)!, nf2.string(from:  123.65)!, nf3.string(from:  123.65)!)
  }

  func test_en_US_AED() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "en_US"), currencyCode: "AED")

    XCTAssertEqual(nf.string(from: -123.65)!, "\(negativeSign)AED\(nbsp)123.65") // -AED 123.65
    XCTAssertEqual(nf.string(from:  123.65)!, "\(positiveSign)AED\(nbsp)123.65") // +AED 123.65
  }

  func test_en_US_ILS() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "en_US"), currencyCode: "ILS")

    XCTAssertEqual(nf.string(from: -123.65)!, "\(negativeSign)\(ILS)123.65") // -₪123.65
    XCTAssertEqual(nf.string(from:  123.65)!, "\(positiveSign)\(ILS)123.65") // +₪123.65
  }

  func test_he_IL_ILS() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "he_IL"), currencyCode: "ILS")

    XCTAssertEqual(nf.string(from: -123.65)!, "\(rtlMark)\(ltrMark)\(negativeSign)123.65\(nbsp)\(ILS)") // -123.65 ₪
    XCTAssertEqual(nf.string(from:  123.65)!, "\(rtlMark)\(ltrMark)\(positiveSign)123.65\(nbsp)\(ILS)") // +123.65 ₪
  }

  func test_he_IL_USD() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "he_IL"), currencyCode: "USD", currencySymbol: "$")

    XCTAssertEqual(nf.string(from: -123.65)!, "\(rtlMark)\(ltrMark)\(negativeSign)123.65\(nbsp)$") // -123.65 $
    XCTAssertEqual(nf.string(from:  123.65)!, "\(rtlMark)\(ltrMark)\(positiveSign)123.65\(nbsp)$") // +123.65 $
  }

  func test_ru_RU_RUB() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ru_RU"), currencyCode: "RUB")

    XCTAssertEqual(nf.string(from: -123.65)!, "−123,65\(nbsp)₽")
    XCTAssertEqual(nf.string(from:  123.65)!, "+123,65\(nbsp)₽")
  }

  func test_ru_RU_USD() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ru_RU"), currencyCode: "USD", currencySymbol: "$")

    XCTAssertEqual(nf.string(from: -123.65)!, "−123,65\(nbsp)$")
    XCTAssertEqual(nf.string(from:  123.65)!, "+123,65\(nbsp)$")
  }

  func test_ru_RU_HKD() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ru_RU"), currencyCode: "HKD")

    XCTAssertEqual(nf.string(from: -123.65)!, "−123,65\(nbsp)HK$")
    XCTAssertEqual(nf.string(from:  123.65)!, "+123,65\(nbsp)HK$")
  }

  // MARK: - English app UI - RTL currencies -

  func test_ar_AE() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ar_AE"))

    XCTAssertEqual(nf.string(from: -123.65)!, "\(ltrMark)\(negativeSign)\(AED)\(rtlMark)\(nbsp)123.65") // -123 \aed
    XCTAssertEqual(nf.string(from:  123.65)!, "\(ltrMark)\(positiveSign)\(AED)\(rtlMark)\(nbsp)123.65") // +123 \aed
  }

  func test_ar_AE_AED() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ar_AE"), currencyCode: "AED")

    XCTAssertEqual(nf.string(from: -123.65)!, "\(ltrMark)\(negativeSign)\(AED)\(rtlMark)\(nbsp)123.65") // -123 \aed
    XCTAssertEqual(nf.string(from:  123.65)!, "\(ltrMark)\(positiveSign)\(AED)\(rtlMark)\(nbsp)123.65") // +123 \aed
  }

  func test_ar_AE_AED_AED() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ar_AE"), currencyCode: "AED", currencySymbol: "AED")

    XCTAssertEqual(nf.string(from: -123.65)!, "\(ltrMark)\(negativeSign)AED\(nbsp)123.65") // -AED 123
    XCTAssertEqual(nf.string(from:  123.65)!, "\(ltrMark)\(positiveSign)AED\(nbsp)123.65") // +AED 123
  }

  func test_ar_AE_USD() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ar_AE"), currencyCode: "USD", currencySymbol: "$")

    XCTAssertEqual(nf.string(from: -123.65)!, "\(ltrMark)−$\(nbsp)123.65") // -$ 123
    XCTAssertEqual(nf.string(from:  123.65)!, "\(ltrMark)+$\(nbsp)123.65") // +$ 123

    XCTAssertEqual(nf.string(from: -123.65)!.trimmingCharacters(in: .controlCharacters), "−$\(nbsp)123.65")
    XCTAssertEqual(nf.string(from:  123.65)!.trimmingCharacters(in: .controlCharacters), "+$\(nbsp)123.65")
  }


  func test_en_QA_AED() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "en_QA"), currencyCode: "AED")

    XCTAssertEqual(nf.string(from: -123.65)!, "\(negativeSign)AED\(nbsp)123.65") // -AED 123
    XCTAssertEqual(nf.string(from:  123.65)!, "\(positiveSign)AED\(nbsp)123.65") // +AED 123
  }

  // MARK: - Arabic app UI -

  func test_ar_QA_AED() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ar_QA"), currencyCode: "AED")
    let arabic_123_65 = "١٢٣٫٦٥"

    XCTAssertEqual(nf.string(from: -123.65)!, "\(u061c)\(negativeSign)\(arabic_123_65)\(nbsp)\(AED)\(rtlMark)") // \aed ١٢٣٫٦٥-
    XCTAssertEqual(nf.string(from:  123.65)!, "\(u061c)\(positiveSign)\(arabic_123_65)\(nbsp)\(AED)\(rtlMark)")
  }

  func test_ar_QA_QAR_QAR() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ar_QA"), currencyCode: "QAR", currencySymbol: "QAR")
    let arabic_123_65 = "١٢٣٫٦٥"

    XCTAssertEqual(nf.string(from: -123.65)!, "\(u061c)\(negativeSign)\(arabic_123_65)\(nbsp)QAR") // \ar_123_65- QAR // ١٢٣٫٦٥- د.د.-
    XCTAssertEqual(nf.string(from:  123.65)!, "\(u061c)\(positiveSign)\(arabic_123_65)\(nbsp)QAR") // ؜+١٢٣٫٦٥ ر.ق.‏
  }

  func test_ar_QA_USD() {
    let nf = PositiveCurrencyFormatter(locale: Locale(identifier: "ar_QA"), currencyCode: "USD")
    let arabic_123_65 = "١٢٣٫٦٥"

    XCTAssertEqual(nf.string(from: -123.65)!, "\(u061c)\(negativeSign)\(arabic_123_65)\(nbsp)US$") // ١٢٣٫٦٥- US$
    XCTAssertEqual(nf.string(from:  123.65)!, "\(u061c)\(positiveSign)\(arabic_123_65)\(nbsp)US$") // ١٢٣٫٦٥+ US$
  }

}

import Foundation

/// A PositiveCurrencyFormatter to format both positive and negative amounts
/// with a proper placement of plus or minus signs according to currency and/or locale.
/// Uses Apple's NumberFormatter under the hood.
public class PositiveCurrencyFormatter: NumberFormatter {

  /// A positive amount sign.
  /// Default value: + PLUS SIGN
  /// Unicode: U+002B, UTF-8: 2B
  public var positiveSign = "+"

  /// A negative amount sign.
  /// Default value: − MINUS SIGN (not ANSI dash/hyphen-minus/U+002D)
  /// Unicode: U+2212, UTF-8: E2 88 92
  public var negativeSign = "−"

  /// A dash sign (U+002D) to replace with a minus sign (U+2212).
  private let dashSign = "-"

  /// A PositiveCurrencyFormatter initializer.
  /// - Parameters:
  ///   - locale: a locale to use when formatting numbers. Default value: `Locale.current`.
  ///   - currencyCode: a currency code to use when formatting numbers. Default value: `"USD"`.
  ///   - currencySymbol: a currency symbol (such as '$') to use when formatting numbers. Default value: `nil`.
  public convenience init(locale: Locale = .current, currencyCode: String? = "USD", currencySymbol: String? = nil) {
    self.init()
    self.locale = locale
    self.currencyCode = currencyCode
    self.currencySymbol = currencySymbol
  }

  private override init() {
    super.init()

    numberStyle = .currency
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func string(from number: NSNumber) -> String? {
    if number.doubleValue >= 0 {
      var value = number.doubleValue
      value.negate()
      return super.string(from: NSNumber(value: value))?
        .replacingOccurrences(of: dashSign, with: positiveSign)
        .replacingOccurrences(of: negativeSign, with: positiveSign)
    }
    return super.string(from: number)?
      .replacingOccurrences(of: dashSign, with: negativeSign)
  }
}

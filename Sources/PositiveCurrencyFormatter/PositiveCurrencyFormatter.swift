import Foundation

/// A PositiveCurrencyFormatter to format both positive and negative amounts
/// with a proper placement of plus or minus signs according to currency and/or locale.
/// Uses Apple's NumberFormatter under the hood.
@available(macOS 10.5, *)
public final class PositiveCurrencyFormatter {

  // MARK: - Private -

  /// Internal instance of CurrencyNumberFormatter.
  private let currencyFormatter: CurrencyNumberFormatter

  /// A dash sign (U+002D) to be replace with a minus sign (U+2212).
  private let dashSign = "-"

  // MARK: - Public -

  /// A positive amount sign.
  /// Default value: + PLUS SIGN
  /// Unicode: U+002B, UTF-8: 2B
  public var positiveSign = "+"

  /// A negative amount sign.
  /// Default value: − MINUS SIGN (not ANSI dash/hyphen-minus/U+002D)
  /// Unicode: U+2212, UTF-8: E2 88 92
  public var negativeSign = "−"

  /// A PositiveCurrencyFormatter initializer.
  ///
  /// - Parameters:
  ///   - locale: a locale to use when formatting numbers. Default value: `Locale.current`.
  ///   - currencyCode: a currency code (such as 'USD') to use when formatting numbers. Default value is `nil`,
  ///   which means there would be a currency provided by locale.
  ///   - currencySymbol: a currency symbol (such as '$') to use when formatting numbers. Default value is `nil`,
  ///   which means there would be a currency sign provided by locale.
  public init(locale: Locale = .current, currencyCode: String? = nil, currencySymbol: String? = nil) {
    let formatter = CurrencyNumberFormatter()
    formatter.locale = locale
    formatter.currencyCode = currencyCode
    formatter.currencySymbol = currencySymbol
    self.currencyFormatter = formatter
  }

  /// Returns a string containing the formatted value of the provided number object.
  ///
  /// - Parameter number: An NSNumber object that is parsed to create the returned string object.
  /// - Returns: A string containing the formatted value of number using the receiver’s current settings.
  public func string(from number: NSNumber) -> String? {
    if number.doubleValue > 0 {
      var value = number.doubleValue
      value.negate()
      return currencyFormatter.string(from: NSNumber(value: value))?
        .replacingOccurrences(of: dashSign, with: positiveSign)
        .replacingOccurrences(of: negativeSign, with: positiveSign)
    }

    return currencyFormatter.string(from: number)?
      .replacingOccurrences(of: dashSign, with: negativeSign)
  }

  // MARK: - Override -

  /// See `NumberFormatter.locale` docs.
  public var locale: Locale! {
    get { currencyFormatter.locale }
    set { currencyFormatter.locale = newValue }
  }

  /// See `NumberFormatter.allowsFloats` docs.
  public var allowsFloats: Bool {
    get { currencyFormatter.allowsFloats }
    set { currencyFormatter.allowsFloats = newValue }
  }

  /// See `NumberFormatter.decimalSeparator` docs.
  public var decimalSeparator: String! {
    get { currencyFormatter.decimalSeparator }
    set { currencyFormatter.decimalSeparator = newValue }
  }

  /// See `NumberFormatter.alwaysShowsDecimalSeparator` docs.
  public var alwaysShowsDecimalSeparator: Bool {
    get { currencyFormatter.alwaysShowsDecimalSeparator }
    set { currencyFormatter.alwaysShowsDecimalSeparator = newValue }
  }

  /// See `NumberFormatter.currencyDecimalSeparator` docs.
  public var currencyDecimalSeparator: String! {
    get { currencyFormatter.currencyDecimalSeparator }
    set { currencyFormatter.currencyDecimalSeparator = newValue }
  }

  /// See `NumberFormatter.usesGroupingSeparator` docs.
  public var usesGroupingSeparator: Bool {
    get { currencyFormatter.usesGroupingSeparator }
    set { currencyFormatter.usesGroupingSeparator = newValue }
  }

  /// See `NumberFormatter.groupingSeparator` docs.
  public var groupingSeparator: String! {
    get { currencyFormatter.groupingSeparator }
    set { currencyFormatter.groupingSeparator = newValue }
  }

  /// See `NumberFormatter.currencyCode` docs.
  public var currencyCode: String! {
    get { currencyFormatter.currencyCode }
    set { currencyFormatter.currencyCode = newValue }
  }

  /// See `NumberFormatter.currencySymbol` docs.
  public var currencySymbol: String! {
    get { currencyFormatter.currencySymbol }
    set { currencyFormatter.currencySymbol = newValue }
  }

  /// See `NumberFormatter.groupingSize` docs.
  public var groupingSize: Int {
    get { currencyFormatter.groupingSize }
    set { currencyFormatter.groupingSize = newValue }
  }

  /// See `NumberFormatter.secondaryGroupingSize` docs.
  public var secondaryGroupingSize: Int {
    get { currencyFormatter.secondaryGroupingSize }
    set { currencyFormatter.secondaryGroupingSize = newValue }
  }

  /// See `NumberFormatter.formatWidth` docs.
  public var formatWidth: Int {
    get { currencyFormatter.formatWidth }
    set { currencyFormatter.formatWidth = newValue }
  }

  /// See `NumberFormatter.paddingCharacter` docs.
  public var paddingCharacter: String! {
    get { currencyFormatter.paddingCharacter }
    set { currencyFormatter.paddingCharacter = newValue }
  }

  /// See `NumberFormatter.paddingPosition` docs.
  public var paddingPosition: NumberFormatter.PadPosition {
    get { currencyFormatter.paddingPosition }
    set { currencyFormatter.paddingPosition = newValue }
  }

  /// See `NumberFormatter.roundingMode` docs.
  public var roundingMode: NumberFormatter.RoundingMode {
    get { currencyFormatter.roundingMode }
    set { currencyFormatter.roundingMode = newValue }
  }

  /// See `NumberFormatter.minimumIntegerDigits` docs.
  public var minimumIntegerDigits: Int {
    get { currencyFormatter.minimumIntegerDigits }
    set { currencyFormatter.minimumIntegerDigits = newValue }
  }

  /// See `NumberFormatter.maximumIntegerDigits` docs.
  public var maximumIntegerDigits: Int {
    get { currencyFormatter.maximumIntegerDigits }
    set { currencyFormatter.maximumIntegerDigits = newValue }
  }

  /// See `NumberFormatter.minimumFractionDigits` docs.
  public var minimumFractionDigits: Int {
    get { currencyFormatter.minimumFractionDigits }
    set { currencyFormatter.minimumFractionDigits = newValue }
  }

  /// See `NumberFormatter.maximumFractionDigits` docs.
  public var maximumFractionDigits: Int {
    get { currencyFormatter.maximumFractionDigits }
    set { currencyFormatter.maximumFractionDigits = newValue }
  }

  /// See `NumberFormatter.currencyGroupingSeparator` docs.
  public var currencyGroupingSeparator: String! {
    get { currencyFormatter.currencyGroupingSeparator }
    set { currencyFormatter.currencyGroupingSeparator = newValue }
  }

  /// See `NumberFormatter.usesSignificantDigits` docs.
  public var usesSignificantDigits: Bool {
    get { currencyFormatter.usesSignificantDigits }
    set { currencyFormatter.usesSignificantDigits = newValue }
  }

  /// See `NumberFormatter.minimumSignificantDigits` docs.
  public var minimumSignificantDigits: Int {
    get { currencyFormatter.minimumSignificantDigits }
    set { currencyFormatter.minimumSignificantDigits = newValue }
  }

  /// See `NumberFormatter.maximumSignificantDigits` docs.
  public var maximumSignificantDigits: Int {
    get { currencyFormatter.maximumSignificantDigits }
    set { currencyFormatter.maximumSignificantDigits = newValue }
  }

}

/// This is not designed to extend.
private class CurrencyNumberFormatter: NumberFormatter {

  override init() {
    super.init()

    numberStyle = .currency
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

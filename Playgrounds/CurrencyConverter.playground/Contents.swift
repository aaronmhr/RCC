import Foundation

func getFlag(from countryCode: String) -> String {
    return countryCode
        .unicodeScalars
        .map({ 127397 + $0.value })
        .compactMap(UnicodeScalar.init)
        .map(String.init)
        .joined()
}

let locale = Locale.current
//let locale = Locale(identifier: "es_ES")
locale.currencySymbol
locale.currencyCode
locale.regionCode

let flag = getFlag(from: locale.regionCode ?? "")

locale.localizedString(forCurrencyCode: "AUD")
locale.localizedString(forCurrencyCode: "BGN")
locale.localizedString(forCurrencyCode: "BRL")
locale.localizedString(forCurrencyCode: "CAD")
locale.localizedString(forCurrencyCode: "CHF")
locale.localizedString(forCurrencyCode: "CNY")
locale.localizedString(forCurrencyCode: "CZK")
locale.localizedString(forCurrencyCode: "DKK")
locale.localizedString(forCurrencyCode: "EUR")
locale.localizedString(forCurrencyCode: "GBP")
locale.localizedString(forCurrencyCode: "HKD")
locale.localizedString(forCurrencyCode: "HRK")
locale.localizedString(forCurrencyCode: "HUF")
locale.localizedString(forCurrencyCode: "IDR")
locale.localizedString(forCurrencyCode: "ILS")
locale.localizedString(forCurrencyCode: "INR")
locale.localizedString(forCurrencyCode: "ISK")
locale.localizedString(forCurrencyCode: "JPY")
locale.localizedString(forCurrencyCode: "KRW")
locale.localizedString(forCurrencyCode: "MXN")
locale.localizedString(forCurrencyCode: "MYR")
locale.localizedString(forCurrencyCode: "NOK")
locale.localizedString(forCurrencyCode: "NZD")
locale.localizedString(forCurrencyCode: "PHP")
locale.localizedString(forCurrencyCode: "PLN")
locale.localizedString(forCurrencyCode: "RON")
locale.localizedString(forCurrencyCode: "RUB")
locale.localizedString(forCurrencyCode: "SEK")
locale.localizedString(forCurrencyCode: "SGD")
locale.localizedString(forCurrencyCode: "THB")
locale.localizedString(forCurrencyCode: "USD")
locale.localizedString(forCurrencyCode: "ZAR")

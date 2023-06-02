//
//  CountriesModel.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit
import Foundation

// MARK: - CountriesElement
struct CountriesElement: Codable {
  let name: Name
  let region: Region
  //    let continents: [Continent]
  let flags: Flags
  let languages: [String:String]?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
  let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
  let signs: [String]?
  let side: Side
}

enum Side: String, Codable {
  case sideLeft = "left"
  case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
  let png: String?
  let svg: String?
}

enum Continent: String, Codable {
  case africa = "Africa"
  case antarctica = "Antarctica"
  case asia = "Asia"
  case europe = "Europe"
  case northAmerica = "North America"
  case oceania = "Oceania"
  case southAmerica = "South America"
}

// MARK: - Currencies
struct Currencies: Codable {
  let jod, usd, rsd, eur: Aed?
  let bmd, bob, lyd, xof: Aed?
  let amd, mur, mvr, mkd: Aed?
  let etb, dkk, iqd, gtq: Aed?
  let ttd, pen, srd, sek: Aed?
  let xpf, fkp, zwl, sar: Aed?
  let aed, afn, xaf, pab: Aed?
  let syp, vuv, hnl, aud: Aed?
  let kid, clp, xcd, mxn: Aed?
  let cny, ssp, szl, zar: Aed?
  let uzs, idr, pyg, pln: Aed?
  let bam: BAM?
  let cad, brl, mru, ils: Aed?
  let ang, bnd, sgd, aoa: Aed?
  let byn, currenciesTRY, gip, btn: Aed?
  let inr, ves, qar, czk: Aed?
  let kwd, nzd, jmd, kyd: Aed?
  let pkr, kzt, bhd, fjd: Aed?
  let isk, mmk, bdt, php: Aed?
  let npr, yer, krw, omr: Aed?
  let ern, irr, tzs, sbd: Aed?
  let kes, dop, gbp, ggp: Aed?
  let rwf, tvd, twd, gyd: Aed?
  let scr, kpw, bwp, khr: Aed?
  let bbd, cop, uah, nad: Aed?
  let top, ars, crc, ghs: Aed?
  let shp, egp, cuc, cup: Aed?
  let huf, bzd, bsd, awg: Aed?
  let stn, rub, fok, nio: Aed?
  let tnd, cdf, nok, sll: Aed?
  let lsl, djf, lkr, wst: Aed?
  let tmt, mdl, chf, mwk: Aed?
  let lbp, mnt, thb, ngn: Aed?
  let cve, jep, dzd, lak: Aed?
  let azn, mad, bgn, bif: Aed?
  let ugx, mzn, gel, ron: Aed?
  let vnd, jpy, lrd, htg: Aed?
  let pgk, hkd, kgs, mga: Aed?
  let gmd, myr, sos, mop: Aed?
  let all, zmw, ckd, gnf: Aed?
  let kmf, imp: Aed?
  let sdg: BAM?
  let tjs, uyu: Aed?
  
  enum CodingKeys: String, CodingKey {
    case jod = "JOD"
    case usd = "USD"
    case rsd = "RSD"
    case eur = "EUR"
    case bmd = "BMD"
    case bob = "BOB"
    case lyd = "LYD"
    case xof = "XOF"
    case amd = "AMD"
    case mur = "MUR"
    case mvr = "MVR"
    case mkd = "MKD"
    case etb = "ETB"
    case dkk = "DKK"
    case iqd = "IQD"
    case gtq = "GTQ"
    case ttd = "TTD"
    case pen = "PEN"
    case srd = "SRD"
    case sek = "SEK"
    case xpf = "XPF"
    case fkp = "FKP"
    case zwl = "ZWL"
    case sar = "SAR"
    case aed = "AED"
    case afn = "AFN"
    case xaf = "XAF"
    case pab = "PAB"
    case syp = "SYP"
    case vuv = "VUV"
    case hnl = "HNL"
    case aud = "AUD"
    case kid = "KID"
    case clp = "CLP"
    case xcd = "XCD"
    case mxn = "MXN"
    case cny = "CNY"
    case ssp = "SSP"
    case szl = "SZL"
    case zar = "ZAR"
    case uzs = "UZS"
    case idr = "IDR"
    case pyg = "PYG"
    case pln = "PLN"
    case bam = "BAM"
    case cad = "CAD"
    case brl = "BRL"
    case mru = "MRU"
    case ils = "ILS"
    case ang = "ANG"
    case bnd = "BND"
    case sgd = "SGD"
    case aoa = "AOA"
    case byn = "BYN"
    case currenciesTRY = "TRY"
    case gip = "GIP"
    case btn = "BTN"
    case inr = "INR"
    case ves = "VES"
    case qar = "QAR"
    case czk = "CZK"
    case kwd = "KWD"
    case nzd = "NZD"
    case jmd = "JMD"
    case kyd = "KYD"
    case pkr = "PKR"
    case kzt = "KZT"
    case bhd = "BHD"
    case fjd = "FJD"
    case isk = "ISK"
    case mmk = "MMK"
    case bdt = "BDT"
    case php = "PHP"
    case npr = "NPR"
    case yer = "YER"
    case krw = "KRW"
    case omr = "OMR"
    case ern = "ERN"
    case irr = "IRR"
    case tzs = "TZS"
    case sbd = "SBD"
    case kes = "KES"
    case dop = "DOP"
    case gbp = "GBP"
    case ggp = "GGP"
    case rwf = "RWF"
    case tvd = "TVD"
    case twd = "TWD"
    case gyd = "GYD"
    case scr = "SCR"
    case kpw = "KPW"
    case bwp = "BWP"
    case khr = "KHR"
    case bbd = "BBD"
    case cop = "COP"
    case uah = "UAH"
    case nad = "NAD"
    case top = "TOP"
    case ars = "ARS"
    case crc = "CRC"
    case ghs = "GHS"
    case shp = "SHP"
    case egp = "EGP"
    case cuc = "CUC"
    case cup = "CUP"
    case huf = "HUF"
    case bzd = "BZD"
    case bsd = "BSD"
    case awg = "AWG"
    case stn = "STN"
    case rub = "RUB"
    case fok = "FOK"
    case nio = "NIO"
    case tnd = "TND"
    case cdf = "CDF"
    case nok = "NOK"
    case sll = "SLL"
    case lsl = "LSL"
    case djf = "DJF"
    case lkr = "LKR"
    case wst = "WST"
    case tmt = "TMT"
    case mdl = "MDL"
    case chf = "CHF"
    case mwk = "MWK"
    case lbp = "LBP"
    case mnt = "MNT"
    case thb = "THB"
    case ngn = "NGN"
    case cve = "CVE"
    case jep = "JEP"
    case dzd = "DZD"
    case lak = "LAK"
    case azn = "AZN"
    case mad = "MAD"
    case bgn = "BGN"
    case bif = "BIF"
    case ugx = "UGX"
    case mzn = "MZN"
    case gel = "GEL"
    case ron = "RON"
    case vnd = "VND"
    case jpy = "JPY"
    case lrd = "LRD"
    case htg = "HTG"
    case pgk = "PGK"
    case hkd = "HKD"
    case kgs = "KGS"
    case mga = "MGA"
    case gmd = "GMD"
    case myr = "MYR"
    case sos = "SOS"
    case mop = "MOP"
    case all = "ALL"
    case zmw = "ZMW"
    case ckd = "CKD"
    case gnf = "GNF"
    case kmf = "KMF"
    case imp = "IMP"
    case sdg = "SDG"
    case tjs = "TJS"
    case uyu = "UYU"
  }
}

// MARK: - Aed
struct Aed: Codable {
  let name, symbol: String
}

// MARK: - BAM
struct BAM: Codable {
  let name: String
}

// MARK: - Demonyms
struct Demonyms: Codable {
  let eng: Eng
  let fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
  let f, m: String
}

// MARK: - Flags
struct Flags: Codable {
  let png: String
  let svg: String
  let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
  let root: String?
  let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
  let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
  let common /*, official*/: String
  let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
  let official, common: String
}

// MARK: - PostalCode
struct PostalCode: Codable {
  let format: String
  let regex: String?
}

enum Region: String, Codable {
  case africa = "Africa"
  case americas = "Americas"
  case antarctic = "Antarctic"
  case asia = "Asia"
  case europe = "Europe"
  case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
  case monday = "monday"
  case saturday = "saturday"
  case sunday = "sunday"
}

enum Status: String, Codable {
  case officiallyAssigned = "officially-assigned"
  case userAssigned = "user-assigned"
}

typealias Countries = [CountriesElement]

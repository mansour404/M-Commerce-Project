//
//  Rates.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

struct Rates : Codable {
	let uSD : Int?
	let aED : Double?
	let aFN : Double?
	let aLL : Double?
	let aMD : Double?
	let aNG : Double?
	let aOA : Double?
	let aRS : Double?
	let aUD : Double?
	let aWG : Double?
	let aZN : Double?
	let bAM : Double?
	let bBD : Int?
	let bDT : Double?
	let bGN : Double?
	let bHD : Double?
	let bIF : Double?
	let bMD : Int?
	let bND : Double?
	let bOB : Double?
	let bRL : Double?
	let bSD : Int?
	let bTN : Double?
	let bWP : Double?
	let bYN : Double?
	let bZD : Int?
	let cAD : Double?
	let cDF : Double?
	let cHF : Double?
	let cLP : Double?
	let cNY : Double?
	let cOP : Double?
	let cRC : Double?
	let cUP : Int?
	let cVE : Double?
	let cZK : Double?
	let dJF : Double?
	let dKK : Double?
	let dOP : Double?
	let dZD : Double?
	let eGP : Double?
	let eRN : Int?
	let eTB : Double?
	let eUR : Double?
	let fJD : Double?
	let fKP : Double?
	let fOK : Double?
	let gBP : Double?
	let gEL : Double?
	let gGP : Double?
	let gHS : Double?
	let gIP : Double?
	let gMD : Double?
	let gNF : Double?
	let gTQ : Double?
	let gYD : Double?
	let hKD : Double?
	let hNL : Double?
	let hRK : Double?
	let hTG : Double?
	let hUF : Double?
	let iDR : Double?
	let iLS : Double?
	let iMP : Double?
	let iNR : Double?
	let iQD : Double?
	let iRR : Double?
	let iSK : Double?
	let jEP : Double?
	let jMD : Double?
	let jOD : Double?
	let jPY : Double?
	let kES : Double?
	let kGS : Double?
	let kHR : Double?
	let kID : Double?
	let kMF : Double?
	let kRW : Double?
	let kWD : Double?
	let kYD : Double?
	let kZT : Double?
	let lAK : Double?
	let lBP : Int?
	let lKR : Double?
	let lRD : Double?
	let lSL : Double?
	let lYD : Double?
	let mAD : Double?
	let mDL : Double?
	let mGA : Double?
	let mKD : Double?
	let mMK : Double?
	let mNT : Double?
	let mOP : Double?
	let mRU : Double?
	let mUR : Double?
	let mVR : Double?
	let mWK : Double?
	let mXN : Double?
	let mYR : Double?
	let mZN : Double?
	let nAD : Double?
	let nGN : Double?
	let nIO : Double?
	let nOK : Double?
	let nPR : Double?
	let nZD : Double?
	let oMR : Double?
	let pAB : Int?
	let pEN : Double?
	let pGK : Double?
	let pHP : Double?
	let pKR : Double?
	let pLN : Double?
	let pYG : Double?
	let qAR : Double?
	let rON : Double?
	let rSD : Double?
	let rUB : Double?
	let rWF : Double?
	let sAR : Double?
	let sBD : Double?
	let sCR : Double?
	let sDG : Double?
	let sEK : Double?
	let sGD : Double?
	let sHP : Double?
	let sLE : Double?
	let sLL : Double?
	let sOS : Double?
	let sRD : Double?
	let sSP : Double?
	let sTN : Double?
	let sYP : Double?
	let sZL : Double?
	let tHB : Double?
	let tJS : Double?
	let tMT : Double?
	let tND : Double?
	let tOP : Double?
	let tRY : Double?
	let tTD : Double?
	let tVD : Double?
	let tWD : Double?
	let tZS : Double?
	let uAH : Double?
	let uGX : Double?
	let uYU : Double?
	let uZS : Double?
	let vES : Double?
	let vND : Double?
	let vUV : Double?
	let wST : Double?
	let xAF : Double?
	let xCD : Double?
	let xDR : Double?
	let xOF : Double?
	let xPF : Double?
	let yER : Double?
	let zAR : Double?
	let zMW : Double?
	let zWL : Double?

	enum CodingKeys: String, CodingKey {

		case uSD = "USD"
		case aED = "AED"
		case aFN = "AFN"
		case aLL = "ALL"
		case aMD = "AMD"
		case aNG = "ANG"
		case aOA = "AOA"
		case aRS = "ARS"
		case aUD = "AUD"
		case aWG = "AWG"
		case aZN = "AZN"
		case bAM = "BAM"
		case bBD = "BBD"
		case bDT = "BDT"
		case bGN = "BGN"
		case bHD = "BHD"
		case bIF = "BIF"
		case bMD = "BMD"
		case bND = "BND"
		case bOB = "BOB"
		case bRL = "BRL"
		case bSD = "BSD"
		case bTN = "BTN"
		case bWP = "BWP"
		case bYN = "BYN"
		case bZD = "BZD"
		case cAD = "CAD"
		case cDF = "CDF"
		case cHF = "CHF"
		case cLP = "CLP"
		case cNY = "CNY"
		case cOP = "COP"
		case cRC = "CRC"
		case cUP = "CUP"
		case cVE = "CVE"
		case cZK = "CZK"
		case dJF = "DJF"
		case dKK = "DKK"
		case dOP = "DOP"
		case dZD = "DZD"
		case eGP = "EGP"
		case eRN = "ERN"
		case eTB = "ETB"
		case eUR = "EUR"
		case fJD = "FJD"
		case fKP = "FKP"
		case fOK = "FOK"
		case gBP = "GBP"
		case gEL = "GEL"
		case gGP = "GGP"
		case gHS = "GHS"
		case gIP = "GIP"
		case gMD = "GMD"
		case gNF = "GNF"
		case gTQ = "GTQ"
		case gYD = "GYD"
		case hKD = "HKD"
		case hNL = "HNL"
		case hRK = "HRK"
		case hTG = "HTG"
		case hUF = "HUF"
		case iDR = "IDR"
		case iLS = "ILS"
		case iMP = "IMP"
		case iNR = "INR"
		case iQD = "IQD"
		case iRR = "IRR"
		case iSK = "ISK"
		case jEP = "JEP"
		case jMD = "JMD"
		case jOD = "JOD"
		case jPY = "JPY"
		case kES = "KES"
		case kGS = "KGS"
		case kHR = "KHR"
		case kID = "KID"
		case kMF = "KMF"
		case kRW = "KRW"
		case kWD = "KWD"
		case kYD = "KYD"
		case kZT = "KZT"
		case lAK = "LAK"
		case lBP = "LBP"
		case lKR = "LKR"
		case lRD = "LRD"
		case lSL = "LSL"
		case lYD = "LYD"
		case mAD = "MAD"
		case mDL = "MDL"
		case mGA = "MGA"
		case mKD = "MKD"
		case mMK = "MMK"
		case mNT = "MNT"
		case mOP = "MOP"
		case mRU = "MRU"
		case mUR = "MUR"
		case mVR = "MVR"
		case mWK = "MWK"
		case mXN = "MXN"
		case mYR = "MYR"
		case mZN = "MZN"
		case nAD = "NAD"
		case nGN = "NGN"
		case nIO = "NIO"
		case nOK = "NOK"
		case nPR = "NPR"
		case nZD = "NZD"
		case oMR = "OMR"
		case pAB = "PAB"
		case pEN = "PEN"
		case pGK = "PGK"
		case pHP = "PHP"
		case pKR = "PKR"
		case pLN = "PLN"
		case pYG = "PYG"
		case qAR = "QAR"
		case rON = "RON"
		case rSD = "RSD"
		case rUB = "RUB"
		case rWF = "RWF"
		case sAR = "SAR"
		case sBD = "SBD"
		case sCR = "SCR"
		case sDG = "SDG"
		case sEK = "SEK"
		case sGD = "SGD"
		case sHP = "SHP"
		case sLE = "SLE"
		case sLL = "SLL"
		case sOS = "SOS"
		case sRD = "SRD"
		case sSP = "SSP"
		case sTN = "STN"
		case sYP = "SYP"
		case sZL = "SZL"
		case tHB = "THB"
		case tJS = "TJS"
		case tMT = "TMT"
		case tND = "TND"
		case tOP = "TOP"
		case tRY = "TRY"
		case tTD = "TTD"
		case tVD = "TVD"
		case tWD = "TWD"
		case tZS = "TZS"
		case uAH = "UAH"
		case uGX = "UGX"
		case uYU = "UYU"
		case uZS = "UZS"
		case vES = "VES"
		case vND = "VND"
		case vUV = "VUV"
		case wST = "WST"
		case xAF = "XAF"
		case xCD = "XCD"
		case xDR = "XDR"
		case xOF = "XOF"
		case xPF = "XPF"
		case yER = "YER"
		case zAR = "ZAR"
		case zMW = "ZMW"
		case zWL = "ZWL"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		uSD = try values.decodeIfPresent(Int.self, forKey: .uSD)
		aED = try values.decodeIfPresent(Double.self, forKey: .aED)
		aFN = try values.decodeIfPresent(Double.self, forKey: .aFN)
		aLL = try values.decodeIfPresent(Double.self, forKey: .aLL)
		aMD = try values.decodeIfPresent(Double.self, forKey: .aMD)
		aNG = try values.decodeIfPresent(Double.self, forKey: .aNG)
		aOA = try values.decodeIfPresent(Double.self, forKey: .aOA)
		aRS = try values.decodeIfPresent(Double.self, forKey: .aRS)
		aUD = try values.decodeIfPresent(Double.self, forKey: .aUD)
		aWG = try values.decodeIfPresent(Double.self, forKey: .aWG)
		aZN = try values.decodeIfPresent(Double.self, forKey: .aZN)
		bAM = try values.decodeIfPresent(Double.self, forKey: .bAM)
		bBD = try values.decodeIfPresent(Int.self, forKey: .bBD)
		bDT = try values.decodeIfPresent(Double.self, forKey: .bDT)
		bGN = try values.decodeIfPresent(Double.self, forKey: .bGN)
		bHD = try values.decodeIfPresent(Double.self, forKey: .bHD)
		bIF = try values.decodeIfPresent(Double.self, forKey: .bIF)
		bMD = try values.decodeIfPresent(Int.self, forKey: .bMD)
		bND = try values.decodeIfPresent(Double.self, forKey: .bND)
		bOB = try values.decodeIfPresent(Double.self, forKey: .bOB)
		bRL = try values.decodeIfPresent(Double.self, forKey: .bRL)
		bSD = try values.decodeIfPresent(Int.self, forKey: .bSD)
		bTN = try values.decodeIfPresent(Double.self, forKey: .bTN)
		bWP = try values.decodeIfPresent(Double.self, forKey: .bWP)
		bYN = try values.decodeIfPresent(Double.self, forKey: .bYN)
		bZD = try values.decodeIfPresent(Int.self, forKey: .bZD)
		cAD = try values.decodeIfPresent(Double.self, forKey: .cAD)
		cDF = try values.decodeIfPresent(Double.self, forKey: .cDF)
		cHF = try values.decodeIfPresent(Double.self, forKey: .cHF)
		cLP = try values.decodeIfPresent(Double.self, forKey: .cLP)
		cNY = try values.decodeIfPresent(Double.self, forKey: .cNY)
		cOP = try values.decodeIfPresent(Double.self, forKey: .cOP)
		cRC = try values.decodeIfPresent(Double.self, forKey: .cRC)
		cUP = try values.decodeIfPresent(Int.self, forKey: .cUP)
		cVE = try values.decodeIfPresent(Double.self, forKey: .cVE)
		cZK = try values.decodeIfPresent(Double.self, forKey: .cZK)
		dJF = try values.decodeIfPresent(Double.self, forKey: .dJF)
		dKK = try values.decodeIfPresent(Double.self, forKey: .dKK)
		dOP = try values.decodeIfPresent(Double.self, forKey: .dOP)
		dZD = try values.decodeIfPresent(Double.self, forKey: .dZD)
		eGP = try values.decodeIfPresent(Double.self, forKey: .eGP)
		eRN = try values.decodeIfPresent(Int.self, forKey: .eRN)
		eTB = try values.decodeIfPresent(Double.self, forKey: .eTB)
		eUR = try values.decodeIfPresent(Double.self, forKey: .eUR)
		fJD = try values.decodeIfPresent(Double.self, forKey: .fJD)
		fKP = try values.decodeIfPresent(Double.self, forKey: .fKP)
		fOK = try values.decodeIfPresent(Double.self, forKey: .fOK)
		gBP = try values.decodeIfPresent(Double.self, forKey: .gBP)
		gEL = try values.decodeIfPresent(Double.self, forKey: .gEL)
		gGP = try values.decodeIfPresent(Double.self, forKey: .gGP)
		gHS = try values.decodeIfPresent(Double.self, forKey: .gHS)
		gIP = try values.decodeIfPresent(Double.self, forKey: .gIP)
		gMD = try values.decodeIfPresent(Double.self, forKey: .gMD)
		gNF = try values.decodeIfPresent(Double.self, forKey: .gNF)
		gTQ = try values.decodeIfPresent(Double.self, forKey: .gTQ)
		gYD = try values.decodeIfPresent(Double.self, forKey: .gYD)
		hKD = try values.decodeIfPresent(Double.self, forKey: .hKD)
		hNL = try values.decodeIfPresent(Double.self, forKey: .hNL)
		hRK = try values.decodeIfPresent(Double.self, forKey: .hRK)
		hTG = try values.decodeIfPresent(Double.self, forKey: .hTG)
		hUF = try values.decodeIfPresent(Double.self, forKey: .hUF)
		iDR = try values.decodeIfPresent(Double.self, forKey: .iDR)
		iLS = try values.decodeIfPresent(Double.self, forKey: .iLS)
		iMP = try values.decodeIfPresent(Double.self, forKey: .iMP)
		iNR = try values.decodeIfPresent(Double.self, forKey: .iNR)
		iQD = try values.decodeIfPresent(Double.self, forKey: .iQD)
		iRR = try values.decodeIfPresent(Double.self, forKey: .iRR)
		iSK = try values.decodeIfPresent(Double.self, forKey: .iSK)
		jEP = try values.decodeIfPresent(Double.self, forKey: .jEP)
		jMD = try values.decodeIfPresent(Double.self, forKey: .jMD)
		jOD = try values.decodeIfPresent(Double.self, forKey: .jOD)
		jPY = try values.decodeIfPresent(Double.self, forKey: .jPY)
		kES = try values.decodeIfPresent(Double.self, forKey: .kES)
		kGS = try values.decodeIfPresent(Double.self, forKey: .kGS)
		kHR = try values.decodeIfPresent(Double.self, forKey: .kHR)
		kID = try values.decodeIfPresent(Double.self, forKey: .kID)
		kMF = try values.decodeIfPresent(Double.self, forKey: .kMF)
		kRW = try values.decodeIfPresent(Double.self, forKey: .kRW)
		kWD = try values.decodeIfPresent(Double.self, forKey: .kWD)
		kYD = try values.decodeIfPresent(Double.self, forKey: .kYD)
		kZT = try values.decodeIfPresent(Double.self, forKey: .kZT)
		lAK = try values.decodeIfPresent(Double.self, forKey: .lAK)
		lBP = try values.decodeIfPresent(Int.self, forKey: .lBP)
		lKR = try values.decodeIfPresent(Double.self, forKey: .lKR)
		lRD = try values.decodeIfPresent(Double.self, forKey: .lRD)
		lSL = try values.decodeIfPresent(Double.self, forKey: .lSL)
		lYD = try values.decodeIfPresent(Double.self, forKey: .lYD)
		mAD = try values.decodeIfPresent(Double.self, forKey: .mAD)
		mDL = try values.decodeIfPresent(Double.self, forKey: .mDL)
		mGA = try values.decodeIfPresent(Double.self, forKey: .mGA)
		mKD = try values.decodeIfPresent(Double.self, forKey: .mKD)
		mMK = try values.decodeIfPresent(Double.self, forKey: .mMK)
		mNT = try values.decodeIfPresent(Double.self, forKey: .mNT)
		mOP = try values.decodeIfPresent(Double.self, forKey: .mOP)
		mRU = try values.decodeIfPresent(Double.self, forKey: .mRU)
		mUR = try values.decodeIfPresent(Double.self, forKey: .mUR)
		mVR = try values.decodeIfPresent(Double.self, forKey: .mVR)
		mWK = try values.decodeIfPresent(Double.self, forKey: .mWK)
		mXN = try values.decodeIfPresent(Double.self, forKey: .mXN)
		mYR = try values.decodeIfPresent(Double.self, forKey: .mYR)
		mZN = try values.decodeIfPresent(Double.self, forKey: .mZN)
		nAD = try values.decodeIfPresent(Double.self, forKey: .nAD)
		nGN = try values.decodeIfPresent(Double.self, forKey: .nGN)
		nIO = try values.decodeIfPresent(Double.self, forKey: .nIO)
		nOK = try values.decodeIfPresent(Double.self, forKey: .nOK)
		nPR = try values.decodeIfPresent(Double.self, forKey: .nPR)
		nZD = try values.decodeIfPresent(Double.self, forKey: .nZD)
		oMR = try values.decodeIfPresent(Double.self, forKey: .oMR)
		pAB = try values.decodeIfPresent(Int.self, forKey: .pAB)
		pEN = try values.decodeIfPresent(Double.self, forKey: .pEN)
		pGK = try values.decodeIfPresent(Double.self, forKey: .pGK)
		pHP = try values.decodeIfPresent(Double.self, forKey: .pHP)
		pKR = try values.decodeIfPresent(Double.self, forKey: .pKR)
		pLN = try values.decodeIfPresent(Double.self, forKey: .pLN)
		pYG = try values.decodeIfPresent(Double.self, forKey: .pYG)
		qAR = try values.decodeIfPresent(Double.self, forKey: .qAR)
		rON = try values.decodeIfPresent(Double.self, forKey: .rON)
		rSD = try values.decodeIfPresent(Double.self, forKey: .rSD)
		rUB = try values.decodeIfPresent(Double.self, forKey: .rUB)
		rWF = try values.decodeIfPresent(Double.self, forKey: .rWF)
		sAR = try values.decodeIfPresent(Double.self, forKey: .sAR)
		sBD = try values.decodeIfPresent(Double.self, forKey: .sBD)
		sCR = try values.decodeIfPresent(Double.self, forKey: .sCR)
		sDG = try values.decodeIfPresent(Double.self, forKey: .sDG)
		sEK = try values.decodeIfPresent(Double.self, forKey: .sEK)
		sGD = try values.decodeIfPresent(Double.self, forKey: .sGD)
		sHP = try values.decodeIfPresent(Double.self, forKey: .sHP)
		sLE = try values.decodeIfPresent(Double.self, forKey: .sLE)
		sLL = try values.decodeIfPresent(Double.self, forKey: .sLL)
		sOS = try values.decodeIfPresent(Double.self, forKey: .sOS)
		sRD = try values.decodeIfPresent(Double.self, forKey: .sRD)
		sSP = try values.decodeIfPresent(Double.self, forKey: .sSP)
		sTN = try values.decodeIfPresent(Double.self, forKey: .sTN)
		sYP = try values.decodeIfPresent(Double.self, forKey: .sYP)
		sZL = try values.decodeIfPresent(Double.self, forKey: .sZL)
		tHB = try values.decodeIfPresent(Double.self, forKey: .tHB)
		tJS = try values.decodeIfPresent(Double.self, forKey: .tJS)
		tMT = try values.decodeIfPresent(Double.self, forKey: .tMT)
		tND = try values.decodeIfPresent(Double.self, forKey: .tND)
		tOP = try values.decodeIfPresent(Double.self, forKey: .tOP)
		tRY = try values.decodeIfPresent(Double.self, forKey: .tRY)
		tTD = try values.decodeIfPresent(Double.self, forKey: .tTD)
		tVD = try values.decodeIfPresent(Double.self, forKey: .tVD)
		tWD = try values.decodeIfPresent(Double.self, forKey: .tWD)
		tZS = try values.decodeIfPresent(Double.self, forKey: .tZS)
		uAH = try values.decodeIfPresent(Double.self, forKey: .uAH)
		uGX = try values.decodeIfPresent(Double.self, forKey: .uGX)
		uYU = try values.decodeIfPresent(Double.self, forKey: .uYU)
		uZS = try values.decodeIfPresent(Double.self, forKey: .uZS)
		vES = try values.decodeIfPresent(Double.self, forKey: .vES)
		vND = try values.decodeIfPresent(Double.self, forKey: .vND)
		vUV = try values.decodeIfPresent(Double.self, forKey: .vUV)
		wST = try values.decodeIfPresent(Double.self, forKey: .wST)
		xAF = try values.decodeIfPresent(Double.self, forKey: .xAF)
		xCD = try values.decodeIfPresent(Double.self, forKey: .xCD)
		xDR = try values.decodeIfPresent(Double.self, forKey: .xDR)
		xOF = try values.decodeIfPresent(Double.self, forKey: .xOF)
		xPF = try values.decodeIfPresent(Double.self, forKey: .xPF)
		yER = try values.decodeIfPresent(Double.self, forKey: .yER)
		zAR = try values.decodeIfPresent(Double.self, forKey: .zAR)
		zMW = try values.decodeIfPresent(Double.self, forKey: .zMW)
		zWL = try values.decodeIfPresent(Double.self, forKey: .zWL)
	}

}

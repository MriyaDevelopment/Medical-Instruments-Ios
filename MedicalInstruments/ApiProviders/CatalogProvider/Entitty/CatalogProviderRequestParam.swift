//
//  CatalogProviderRequestParam.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 11.03.2022.
//

import Foundation

struct getInstrumentsByTypeRequestParams {
    let type: String

    init(type: String) {
        self.type = type
    }
}

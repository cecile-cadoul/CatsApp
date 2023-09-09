//
//  LocalRepository.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import Foundation

protocol LocalRepository {

    func saveData<T>(data: [T])
    func deleteData<T>(data: [T])

}

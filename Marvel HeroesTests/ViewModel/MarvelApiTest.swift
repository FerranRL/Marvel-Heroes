//
//  MockMarvelApi.swift
//  Marvel HeroesTests
//
//  Created by f.rosales.lopera on 27/7/21.
//

import XCTest
import Foundation
import Alamofire
import SwiftHash

@testable import Marvel_Heroes

class MarvelApiTest: XCTestCase {
    
    var sut: HomeViewModel?
    
    override func setUp() {
        sut = HomeViewModel()
    }
    
     override func tearDown() {
        sut = nil
    }
    
    func testLoadHeros() {
        let expectation = XCTestExpectation(description: "Comprobar que se obtiene datos de la API de Marvel")
        
        sut?.loadAllHeroes(name: "", completion: { (info) in
            XCTAssertNotNil(info, "No se han obtenido datos")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
   
    
    
    
}


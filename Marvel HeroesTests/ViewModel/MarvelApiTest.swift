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
    
    var sut: MarvelViewModel?
    
    override func setUp() {
        sut = MarvelViewModel()
    }
    
     override func tearDown() {
        sut = nil
    }
    
    func testLoadHeros() {
        let expectation = XCTestExpectation(description: "Comprobar que se obtiene datos de la API de Marvel")
        
        MarvelViewModel.loadHeroes(name: "", onComplete: { info in
            XCTAssertNotNil(info, "No se han obtenido datos")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLoadHeroByID() {
        
        
        let expectation = XCTestExpectation(description: "Obtener la información del personaje que corresponde al id proporcionado")
        let idHero = 1011334
        
        
        MarvelViewModel.loadHero(id: idHero, onComplete: { info in
            
            XCTAssertNotNil(info, "No se han obtenido datos")
            expectation.fulfill()

        })
        
        wait(for: [expectation], timeout: 5.0)
    
    }
    
    func testLoadHeroByIDCheckMatch() {
        
        
        let expectation = XCTestExpectation(description: Constants.testDescriptionLoadByID)
        let idHero = 1011334
        
        
        MarvelViewModel.loadHero(id: idHero, onComplete: { info in
            
            let hero = info.data.results[0]
            XCTAssertEqual(idHero, hero.id, testNotMatch)
            expectation.fulfill()

        })
        
        wait(for: [expectation], timeout: 5.0)
    
    }
    
    
    
}


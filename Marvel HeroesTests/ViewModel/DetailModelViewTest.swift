//
//  DetailModelViewTest.swift
//  Marvel HeroesTests
//
//  Created by f.rosales.lopera on 27/9/21.
//

import XCTest
import Foundation
import Alamofire
import SwiftHash

@testable import Marvel_Heroes

class DetailModelViewTest: XCTestCase {
    
    var sut: DetailViewModel?
    
    override func setUp() {
        sut = DetailViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testLoadHeroByID() {
        
        
        let expectation = XCTestExpectation(description: "Obtener la información del personaje que corresponde al id proporcionado")
        let idHero = 1011334
        
        sut?.loadHero(id: idHero, completion: { (info) in
            XCTAssertNotNil(info, "No se han obtenido datos")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    
}

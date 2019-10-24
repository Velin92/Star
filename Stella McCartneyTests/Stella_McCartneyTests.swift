//
//  Stella_McCartneyTests.swift
//  Stella McCartneyTests
//
//  Created by Mauro Romito on 17/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import XCTest
@testable import Stella_McCartney

class Stella_McCartneyTests: XCTestCase {
    
    func testMenuViewModel() {
        let mockViewController = MenuViewControllerMock()
        let viewModel = MenuViewModel(view: mockViewController)
        viewModel.tappedOnAccessories()
        XCTAssert(mockViewController.listType == .accessories)
        viewModel.tappedOnReadyToWear()
        XCTAssert(mockViewController.listType == .readyToWear)
        viewModel.tappedOnBeauty()
        XCTAssert(mockViewController.listType == .beauty)
        viewModel.tappedOnLingerie()
        XCTAssert(mockViewController.listType == .lingerie)
    }
    
    func testProductsListMacroSections() {
        let mockViewController = ProductsListViewControllerMock()
        let apiClientMock = APIClientMock()
        apiClientMock.productListResponse = try! JSONDecoder().decode(ProductsListResponse.self, from: Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "ProductsListResponse", withExtension: "json")!))
        let imageServiceMock = ImageServiceMock()
        imageServiceMock.data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "48199194BH_8_c", withExtension: "jpg")!)
        let interactor = ProductsListInteractor(of: .accessories, apiService: apiClientMock, imageService: imageServiceMock)
        let viewModel = ProductsListViewModel(view: mockViewController, interactor: interactor)
        viewModel.loadProductsList()
        XCTAssert(mockViewController.viewState.productSections.count == 3)
    }
    
    func testProductListMicroSections() {
        let mockViewController = ProductsListViewControllerMock()
        let apiClientMock = APIClientMock()
        apiClientMock.productListResponse = try! JSONDecoder().decode(ProductsListResponse.self, from: Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "ProductsListResponseSingleMacro", withExtension: "json")!))
        let imageServiceMock = ImageServiceMock()
         imageServiceMock.data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "48199194BH_8_c", withExtension: "jpg")!)
        let interactor = ProductsListInteractor(of: .accessories, apiService: apiClientMock, imageService: imageServiceMock)
        let viewModel = ProductsListViewModel(view: mockViewController, interactor: interactor)
        viewModel.loadProductsList()
        
        XCTAssert(mockViewController.viewState.productSections.count == 2)
    }
    
    func testProductsListErrorView() {
        let mockViewController = ProductsListViewControllerMock()
        let apiClientMock = APIClientMock()
        apiClientMock.isFailureTest = true
        let imageServiceMock = ImageServiceMock()
        let interactor = ProductsListInteractor(of: .accessories, apiService: apiClientMock, imageService: imageServiceMock)
        let viewModel = ProductsListViewModel(view: mockViewController, interactor: interactor)
        viewModel.loadProductsList()
        XCTAssert(mockViewController.errorScreenIsShown)
    }
    
    func testProductsListNoItems() {
        let mockViewController = ProductsListViewControllerMock()
        let apiClientMock = APIClientMock()
        apiClientMock.productListResponse = try!JSONDecoder().decode(ProductsListResponse.self,from: Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "ProductsListJsonItemless", withExtension: "json")!))
        let imageServiceMock = ImageServiceMock()
         imageServiceMock.data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "48199194BH_8_c", withExtension: "jpg")!)
        let interactor = ProductsListInteractor(of: .accessories, apiService: apiClientMock, imageService: imageServiceMock)
        let viewModel = ProductsListViewModel(view: mockViewController, interactor: interactor)
        viewModel.loadProductsList()
        XCTAssert(mockViewController.errorScreenIsShown)
    }
    
    func testProductsListWithDiscounts() {
        let mockViewController = ProductsListViewControllerMock()
        let apiClientMock = APIClientMock()
        apiClientMock.productListResponse = try!JSONDecoder().decode(ProductsListResponse.self,from: Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "ProductsListResponseDiscounts", withExtension: "json")!))
        let imageServiceMock = ImageServiceMock()
         imageServiceMock.data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "48199194BH_8_c", withExtension: "jpg")!)
        let interactor = ProductsListInteractor(of: .accessories, apiService: apiClientMock, imageService: imageServiceMock)
        let viewModel = ProductsListViewModel(view: mockViewController, interactor: interactor)
        viewModel.loadProductsList()
        XCTAssert(mockViewController.viewState.productSections[0].products[0].formattedPrice == "1195€")
         XCTAssert(mockViewController.viewState.productSections[1].products[0].formattedPrice == "1295€")
        XCTAssert(mockViewController.viewState.productSections[2].products[0].formattedPrice == "1295€")
    }
    
    func testTapProduct() {
        let mockViewController = ProductsListViewControllerMock()
        let apiClientMock = APIClientMock()
        apiClientMock.productListResponse = try!JSONDecoder().decode(ProductsListResponse.self,from: Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "ProductsListResponse", withExtension: "json")!))
        let imageServiceMock = ImageServiceMock()
         imageServiceMock.data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "48199194BH_8_c", withExtension: "jpg")!)
        let interactor = ProductsListInteractor(of: .accessories, apiService: apiClientMock, imageService: imageServiceMock)
        let viewModel = ProductsListViewModel(view: mockViewController, interactor: interactor)
        viewModel.loadProductsList()
        viewModel.selectedProduct(at: 0, in: 0)
        XCTAssert(mockViewController.product!.code8! == "0")
        viewModel.selectedProduct(at: 0, in: 1)
        XCTAssert(mockViewController.product!.code8! == "1")
        viewModel.selectedProduct(at: 0, in: 2)
        XCTAssert(mockViewController.product!.code8! == "2")
        viewModel.selectedProduct(at: 1, in: 2)
        XCTAssert(mockViewController.product!.code8! == "3")
    }
    
    func testProductDetailErrors() {
        let mockViewController = ProductDetailViewControllerMock()
        let apiClientMock = APIClientMock()
        let imageServiceMock = ImageServiceMock()
        imageServiceMock.data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "48199194BH_8_c", withExtension: "jpg")!)
        let product = Product(code8: "a", brandName: "b", defaultCode10: "c", macroCategory: "d", microCategory: "e", fullPrice: 1, discountedPrice: 1, modelNames: "test", sizes: [], colors: [])
        let interactor = ProductDetailInteractor(product: product, apiService: apiClientMock, imageService: imageServiceMock)
        let viewModel = ProductDetailViewModel(view: mockViewController, interactor: interactor)
        apiClientMock.isFailureTest = true
        viewModel.loadView()
        XCTAssert(mockViewController.viewState.colorText ==  """
                   Informazioni aggiuntive non disponibili.
                   Verificare la connessione e riprovare più tardi
                   """)
        XCTAssert(mockViewController.viewState.additionalInfoState == .missing)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

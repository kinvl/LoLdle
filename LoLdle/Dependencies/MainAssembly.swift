//
//  MainAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 09/09/2022.
//

import Swinject

final class MainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainViewController.self) { resolver in
            let viewModel = resolver.resolve(MainViewModeling.self)!
            let router = resolver.resolve(MainRouting.self)!
            return MainViewController(viewModel: viewModel, router: router)
        }
        
        container.register(MainViewModeling.self) { resolver in
            let getRemoteDataCountUseCase = resolver.resolve(GettingRemoteDataCountUseCase.self)!
            let getLocalDataCountUseCase = resolver.resolve(GettingLocalDataCountUseCase.self)!
            let downloadChampionsDataUseCase = resolver.resolve(DownloadingChampionsDataUseCase.self)!
            return MainViewModel(getRemoteDataCountUseCase: getRemoteDataCountUseCase, getLocalDataCountUseCase: getLocalDataCountUseCase, downloadChampionsDataUseCase: downloadChampionsDataUseCase)
        }
        
        container.register(MainRouting.self) { resolver in
            return MainRouter()
        }
    }
}

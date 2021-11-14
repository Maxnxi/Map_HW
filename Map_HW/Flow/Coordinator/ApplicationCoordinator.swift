//
//  ApplicationCoordinator.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 14.11.2021.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator {

    override func start() {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            toMain()
        } else {
                toAuth()
            }
    }
    
    private func toMain() {
        // Создаём координатор главного сценария
        let coordinator = MainCoordinator() // Устанавливаем ему поведение на завершение
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            // Так как подсценарий завершился, держать его в памяти больше не нужно
            self?.removeDependency(coordinator)
            // Заново запустим главный координатор, чтобы выбрать следующий сценарий
            self?.start() }
        // Сохраним ссылку на дочерний координатор, чтобы он не выгружался из памяти
        addDependency(coordinator)
        // Запустим сценарий дочернего координатора
        coordinator.start()
    }
    
    private func toAuth() {
        // Создаём координатор сценария авторизации
        let coordinator = AuthCoordinator() // Устанавливаем ему поведение на завершение
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            // Так как подсценарий завершился, держать его в памяти больше не нужно
            self?.removeDependency(coordinator)
            // Заново запустим главный координатор, чтобы выбрать выбрать следующий // сценарий
            self?.start() }
        // Сохраним ссылку на дочерний координатор, чтобы он не выгружался из памяти
        addDependency(coordinator)
        // Запустим сценарий дочернего координатора
        coordinator.start()
    }
}

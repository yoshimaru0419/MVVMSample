//
//  ContentView.swift
//  MVVMSample
//
//  Created by 樹佳 on 2023/04/03.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject private var vModel: DataViewModel
    
    init(vModel: DataViewModel) {
        self.vModel = vModel
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Count: \(vModel.count)")
            HStack {
                Button("CountUp", action: {vModel.countUp()})
                Button("CountDown", action: {vModel.countDown()})
                Button("Save Count", action: {vModel.save()})
                Button("load", action: {vModel.load()})
            }
            Text("UserDefaults Data=\(vModel.UserDefaultData)")
        }
        .padding()
    }
}

// ViewModel
class DataViewModel : ObservableObject {
    
    @Published var count: Int
    @Published var UserDefaultData: Int = 0
    
    private var model: Data
    private var repository: DataRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.model = Data()
        self.count = model.value
        self.repository = DataRepository()
        createSubscribe()
    }
    
    // Subscribe（購読者）の設定を行う
    // Model 側で持つデータが更新されたら sink が実行されて、更新されたデータが value に来る
    // 受け取ったものを viewModel の値更新に利用して View に通知
    private func createSubscribe() {
        self.model.$value.sink(receiveValue: { value in
            self.count = value
        })
        .store(in: &cancellables)
    }
    
    func countUp() {
        model.increment()
    }
    
    func countDown() {
        model.decrement()
    }
    
    func save() {
        repository.saveData(value: model.value)
    }
    
    func load() {
        UserDefaultData = repository.fetchData()
    }

}

// Model
class Data {
    @Published var value: Int = 0
    
    func increment() {
        self.value = value + 1
    }
    
    func decrement() {
        self.value = value - 1
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vModel: DataViewModel())
    }
}

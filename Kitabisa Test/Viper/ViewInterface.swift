//import IGListKit

protocol ViewInterface: class {
    func showLoader(_ show: Bool)
    
    func showData<T: Codable>(_ data: [T])
//    func showData(_ data: [ListDiffable], scrollToItem item: ListDiffable)
//    func reloadItem(_ item: ListDiffable)
}

extension ViewInterface {
    func showLoader(_ show: Bool) {
        fatalError("Implementation pending...")
    }
    
    

    func showData<T: Codable>(_ data: [T]) {
        fatalError("Implementation pending...")
    }
//
//    func showData(_ data: [ListDiffable], scrollToItem item: ListDiffable) {
//        fatalError("Implementation pending...")
//    }
//
//    func reloadItem(_ item: ListDiffable) {
//        fatalError("Implementation pending...")
//    }
}

import Foundation
import Combine

final class EncountViewModel: ObservableObject {
    private var encountRepository: EncounterRepositoryProtocol!
    private var cancellables = Set<AnyCancellable>()

    init(repository: EncounterRepositoryProtocol) {
        self.encountRepository = repository
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: Notification.Name("RecieveNotification"), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func handleNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let encounter = userInfo["encounter"] as! Int
        encountRepository.getEncountInfo()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else {return}
                switch $0 {
                case .finished:
                    print("終了します")
                    return
                case .failure(let error):
                    print(error)
                    return
                }
            } receiveValue: { encountInfo in
                self.encountInfos = encountInfo
            }
            .store(in: &cancellables)

    }

    @Published var encountInfos: [EncountInfoModel] = [
        EncountInfoModel(
            userInfo: UserProfileModel(
                userName: "しゅうと",
                bikeName: "DSC400",
                profileIcon: nil,
                touringcomment: "みんなよろしくね"
            ),
            touringInfo: TouringInfoModel(
                destinationName: "サン春日丘",
                touringComment: nil
            ),
            encountLocationLatitude: 34.9154073,
            encountLocationLongitude: 135.6485139
        ),
        EncountInfoModel(
            userInfo: UserProfileModel(
                userName: "しゅうと",
                bikeName: "DSC400",
                profileIcon: nil,
                touringcomment: "みんなよろしくね"
            ),
            touringInfo: TouringInfoModel(
                destinationName: "サン春日丘",
                touringComment: nil
            ),
            encountLocationLatitude: 34.1154073,
            encountLocationLongitude: 135.3485139
        ),
        EncountInfoModel(
            userInfo: UserProfileModel(
                userName: "しゅうと",
                bikeName: "DSC400",
                profileIcon: nil,
                touringcomment: "みんなよろしくね"
            ),
            touringInfo: TouringInfoModel(
                destinationName: "サン春日丘",
                touringComment: nil
            ),
            encountLocationLatitude: 34.8154073,
            encountLocationLongitude: 135.5485139
        ),
        EncountInfoModel(
            userInfo: UserProfileModel(
                userName: "しゅうと",
                bikeName: "DSC400",
                profileIcon: nil,
                touringcomment: "みんなよろしくね"
            ),
            touringInfo: TouringInfoModel(
                destinationName: "サン春日丘",
                touringComment: nil
            ),
            encountLocationLatitude: 34.7154073,
            encountLocationLongitude: 135.4485139
        )
    ]

    func getEncounter() {
        encountRepository.getEncountInfo()
            .receive(on: DispatchQueue.main)
            .sink { response in
                switch response {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { result in
                self.encountInfos = result
            }
            .store(in: &cancellables)

    }

}

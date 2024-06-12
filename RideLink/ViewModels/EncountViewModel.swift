import Foundation
import Combine

final class EncountViewModel: ObservableObject {
    private var encountRepository: EncounterRepositoryProtocol!
    private var cancellables = Set<AnyCancellable>()

    init(repository: EncounterRepositoryProtocol) {
        self.encountRepository = repository
    }

    @Published var encountInfos: [EncountInfoModel] = [
        EncountInfoModel(
            userInfo: UserProfileModel(
                userName: "しゅうと",
                bikeName: "DSC400",
                profileIcon: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhmLEQFa1-bwtYr1Pf2_TtiH5jSyY-hLW72Oi8ahq-RSqQlujO4TPvXz4vIugZIXampL_yGk1ReNEWTOPtEQfSQ3nSS0GTPkYJX4xCEhlE-ETT4yqW7CqLYv5EDdc4UjIMe3WIc0OittEwC/s800/bike_helmet_man.png",
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
                profileIcon: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgIkaA2NYA1MjyDjhbiHLEqq8kq9dXEZ3lJM27gS6rbqjQuWZgnCeuCspZY4s64MangZ1SosRQuTARIDU23ycehzVIipHlMCmXYmo49-V87XRNPudMyfd5SBJG0s662Pm0Jr4rej5FO7bE9/s800/bike_offroad_motocross.png",
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
                profileIcon: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJP4jx3kZeCRfKzX0IsTB8_kce5gLi7raiFba58VKyK3F86xFAdiOXLA9sqWJVTKv-APSmtsJet_zrMjBVLmYbbTT_yTyUdUHIxNTr_ePtMwXxA1kGHcRC7vm3UHwjiMbeM2jdmuDd0eft/s800/bike_american_choppers_man.png",
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
                profileIcon: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2d2lt0_uYp9zWhfiDHpqrSKLnKgfvmPdsh0MkEo6dfqZTF52It_O98C6SsqH87x0KWGtJNdSWqrAFVNn6T9n8jszhJF3B62-ycrAbAG4wSCEckDf4uI_qZwDUdt8cfhU4xpTkuzgFzLU/s800/delivery_bike.png",
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

# Zipadoo 리드미

## 🌎 스크린샷

![Zipadoo리드미스크린샷 001](https://github.com/nhyeonjeong/zipadoo/assets/102401977/478e43fa-f53c-4838-957f-bc08108c415f)
![Zipadoo리드미스크린샷 002](https://github.com/nhyeonjeong/zipadoo/assets/102401977/5fd6b564-98de-4bcc-971a-c58d11f21450)


## 🌎 프로젝트 소개
> 친구들과 약속을 잡고 각자의 위치를 공유해 지각자를 확인하는 앱
- iOS 7인 협업
- 개발 기간
    - 23.09.20 ~ 23.10.24
    - [🔗APP Store 출시](https://apps.apple.com/kr/app/%EC%A7%80%ED%8C%8C%EB%91%90/id6474185787) / 현재 v1.0.2
- 개발 환경
    - 최소버전 17.0
    - 세로모드
    - 라이트뭐드, 다크모드 지원
 
## 🌎 핵심기능
- 약속 등록
- 약속 시간 30분 전 ~ 약속 시간 3시간 후 동안 지도상 위치공유 및 남은 거리 확인
- 지난 약속 결과 확인
- 친구 신청 및 관리

## 🌎 사용한 기술스택
- SwiftUI, MVVM
- Alamofire, MapKit, CoreLocation, Kingfisher, Toast, Lottie, SlidingTabView, UserNotification, Widget
- FirebaseDatabase, FirebaseStorage, 
- SwiftConcurrency, Singleton, customModifier, customView, UIViewRepresentable, UIImagePickerControllerDelegate

## 🌎 기술설명
- MVVM형태에 여러뷰에 필요한 store을 섞어 유동적으로 개발 진행
  - Firebase통신이나 GPS사용을 위한 다수의 Store 클래스와 특정 View에서 사용되는 ViewModel을 View에서 초기화
  - 로그인 / 유저 / 약속 / 친구 / 마이페이지 / 위치 Store 클래스로 관리
- .task를 사용해 뷰를 그리기 전 나의 gps정보 확인
- Timer로 5초마다 Database에 사용자의 위도 경도 저장 및 패치 후 annotation표시
- Concurrency를 사용해 database통신
  - 순서가 중요한 여러 작업을 async throw 와 try await 키워드를 사용해 동기적으로 작성

## 🌎 트러블슈팅

### `1. onAppear와 task modifier`

1-1) 문제

뷰에 진입시 gps로 사용자의 위치를 가져와 위치정보를 사용해 map에 anootation을 띄우고 싶었지만 onAppear에서 GPSStore에 접근후 위도,경도의 결과는 항상 nil.
때문에 나의 현재 위치 표시와 위도,경도 업데이트 불가.

1-2) 해결

gps정보를 가져올 때 실행되는 함수는 
task가 onAppear보다 더 나중 시점에 실행되며 view가 보여질 때 비동기로 일을 처리하고 뷰의 수명과 일치하다는 장점 확인.
onAppear대신 task modifier 내부에 현재위치를 가져오는 코드 작성.

<details>
<summary>변경 후 코드</summary>
<div markdown="1">

<img width="652" alt="스크린샷 2024-07-02 오후 3 58 27" src="https://github.com/nhyeonjeong/zipadoo/assets/102401977/6cdf7936-a6b8-437b-895d-2fa922704fc6">

</div>
</details>

### `2. DTO: 새로운 구조체 생성`

2-1) 문제

데이터베이스 조회 후 서로 다른 구조체에 들어가 있는 위치정보와 유저의 개인정보를 맵뷰에 같이 불러와야 하는 문제. 
annotation으로 표시된 유저읭 현재 위치에 각 유저의 이름과 캐릭터를 쉽게 매치하는 방법을 모색.

2-2) 해결

유저마다의 위치 구조체가 유저 id를 가지고 있는 관계로 이를 해결하기 위해 유저정보와 위치정보 모두를 가진 또 하나의 LocationAndParticipant 구조체 형성.
위치구조체 내부의 유저 id로 유저정보를 가져와 새로운 구조체에 맞게 배열에 저장하는 방식으로 해결.

<details>
<summary>변경 후 코드</summary>
<div markdown="1">

<img width="489" alt="스크린샷 2024-07-02 오후 5 06 04" src="https://github.com/nhyeonjeong/zipadoo/assets/102401977/af9b4726-e1f1-4a01-8ac6-0873011220f4">
<img width="844" alt="스크린샷 2024-07-02 오후 5 08 05" src="https://github.com/nhyeonjeong/zipadoo/assets/102401977/e9859282-b81b-4ddb-bca2-aba25bce0d8f">

</div>
</details>

### `3. Timer멈추기`

3-1) 문제

위치를 추적하고 있을 동안 사용자가 도착했다면 timer를 멈추고 사용자의 도착정보에 대해서 저장하는 로직이 없어 백그라운드에서 필요없는 Timer가 진행되는 문제 발견.

2-2) 해결

1초마다 사용자가 도착했는지 확인하는 함수와 Enum 생성후 도착한 상태였다면 타이머 종료.
도착여부는 도착한 시간의 존재유무로 판별.
또한 5초마다 현재위치를 갱신하는 과정에서 사용자가 도착반경안에 들어왔다면 도착한 시간을 저장하는 방식으로 해결.

<details>
<summary>변경 후 코드</summary>
<div markdown="1">

<img width="513" alt="스크린샷 2024-07-02 오후 5 46 36" src="https://github.com/nhyeonjeong/zipadoo/assets/102401977/e6ef49bf-2f9a-42b6-9d2b-dd525521e3b4">

```swift
 timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: locationStore.myLocation.arriveTime == 0) { _ in

    // 추적 종료된 약속인지 계산 -> 추적이 종료되면 지각횟수와 약속수 갱신 & 타이머 종료 & 뷰에서 나가는 알람
    timeType = classifyTime(promiseDate: promiseDate, afterThreeHourTime: afterThreeHourTime)
    // 추적이 종료됐다면 timer반복문 탈출
    if timeType == .endTracking {
        print("endTracking")
        // 타이머 종료
        timer?.invalidate()
        timer = nil
        Task {
            // 지각횟수, 약속수 갱신
            do {
                print("updateTrady")
                try await UserStore.updatePromiseTradyCount(promiseDate: promise.promiseDate, arriveTime: locationStore.myLocation.arriveTime)
            } catch {
                print("updatePromiseTradyCount실패")
            }
        }
        // 뷰탈출
        dismiss()
    } else {
        updateTimer += 1
        if updateTimer % 5 == 0 && locationStore.myLocation.arriveTime == 0 {
            updateTimer = 0 // 다시 초기화
            // 도착하지 않았을 때만 도착확인
            isArrived = didYouArrive(currentCoordinate:
                                        CLLocation( latitude: gpsStore.lastSeenLocation?.coordinate.latitude ?? 0,
                                                    longitude: gpsStore.lastSeenLocation?.coordinate.longitude ?? 0),
                                     arrivalCoordinate: CLLocation(latitude: promise.latitude, longitude: promise.longitude), effectiveDistance: arrivalCheckRadius)
            
            // 도착했다면 파베에 업데이트 및 locationStore.myLocation정보갱신
            // 도착하지 않았다면 위치 업데이트
            if isArrived == true {
                locationStore.myLocation.arriveTime = Date().timeIntervalSince1970
                let rank = locationStore.calculateRank()
                locationStore.updateArriveTime(locationId: locationStore.myLocation.id, arriveTime: locationStore.myLocation.arriveTime, rank: rank)
                // 도착 알림 실행
                alertStore.arrivalMsgAlert = ArrivalMsgModel(name: AuthStore.shared.currentUser?.nickName ?? "이름없음", profileImgString: AuthStore.shared.currentUser?.profileImageString ?? "doo1", rank: rank, arrivarDifference: promise.promiseDate - locationStore.myLocation.arriveTime, potato: 0)
                alertStore.isPresentedArrival.toggle()
                
            } else {
                locationStore.updateCurrentLocation(locationId: locationStore.myLocation.id, newLatitude: gpsStore.lastSeenLocation?.coordinate.latitude ?? 0, newLongtitude: gpsStore.lastSeenLocation?.coordinate.longitude ?? 0)
            }
        }
    }
}
RunLoop.current.add(timer ?? Timer(), forMode: .default)
```

</div>
</details>


## 🌎 기술회고
customView로 코드를 뷰를 분리해 반복적으로 사용되는 프로필 사진 등을 쉽게 사용할 수 있었고, 뷰 초기화시 사이즈를 enum타입으로 받음으로서 협업시 사이즈 오타 실수를 줄일 수 있었습니다.
기술적으로 한계를 느꼈던 부분은 위치를 데이터베이스에 갱신하는 로직의 작동 시점이었고, 백그라운드에서의 Timer동작에 대해 생각해보는 데에 도움이 되었습니다. 과도한 위치 업데이트로 인해 데이터베이스에 과부하가 오는 것을 보며 성능과 사용자 경험 사이의 밸런스에 대해서도 생각해보게 되었습니다. 
또한 Concurrency를 사용해 데이터베이스 접근을 순차적으로 하려고 했으나, 너무 남용한 것 같아 동기적인 작동이 꼭 필요한 곳에 사용하기로 했습니다.

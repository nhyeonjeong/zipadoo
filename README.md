# Zipadoo 리드미

## 🌎스크린샷

![Zipadoo리드미스크린샷 001](https://github.com/nhyeonjeong/zipadoo/assets/102401977/478e43fa-f53c-4838-957f-bc08108c415f)
![Zipadoo리드미스크린샷 002](https://github.com/nhyeonjeong/zipadoo/assets/102401977/5fd6b564-98de-4bcc-971a-c58d11f21450)


## 🌎프로젝트 소개
> 친구들과 약속을 잡고 각자의 위치를 공유해 지각자를 확인하는 앱
- iOS 7인 협업
- 개발 기간
    - 23.09.20 ~ 23.10.24
    - [🔗APP Store 출시](https://apps.apple.com/kr/app/%EC%A7%80%ED%8C%8C%EB%91%90/id6474185787) / 현재 v1.0.2
- 개발 환경
    - 최소버전 17.0
    - 세로모드
    - 라이트뭐드, 다크모드 지원
 
## 🌎핵심기능
- 약속 등록
- 약속 시간 30분 전 ~ 약속 시간 3시간 후 동안 지도상 위치공유 및 남은 거리 확인
- 지난 약속 결과 확인
- 친구 신청 및 관리

## 🌎사용한 기술스택
- SwiftUI, MVVM
- Alamofire, MapKit, CoreLocation, Kingfisher, Toast, Lottie, SlidingTabView, UserNotification, Widget
- FirebaseDatabase, FirebaseStorage, 
- SwiftConcurrency, Singleton, customModifier, customView, UIViewRepresentable, UIImagePickerControllerDelegate

## 🌎기술설명
- MVVM형태에 여러뷰에 필요한 store을 섞어 유동적으로 개발 진행
  - Firebase통신이나 GPS사용을 위한 다수의 Store 클래스와 특정 View에서 사용되는 ViewModel을 View에서 초기화
  - 로그인 / 유저 / 약속 / 친구 / 마이페이지 / 위치 Store 클래스로 관리
- .task를 사용해 뷰를 그리기 전 나의 gps정보 확인
  - gps정보를 빨리 가져오기 위해 onAppear보다 빠른 task사용
- Timer로 5초마다 Database에 사용자의 위도 경도 저장 및 패치 후 annotation표시
- Concurrency를 사용해 database통신
  - 순서가 중요한 여러 작업을 async throw 와 try await 키워드를 사용해 동기적으로 작성

## 🌎트러블슈팅
### `1. `

1-1) 문제



1-2) 해결


<details>
<summary>변경 후 코드</summary>
<div markdown="1">


</div>
</details>



## 🌎기술회고

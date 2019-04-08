# Flutter Me with Weather

레이어는 아래 처럼

- UI
- Domain
  - Models
  - UseCases
  - Repositories
- Data

## 우선은 필요한 도메인 로직, UseCase 정리

### UseCase

- 사용자가 검색한 위치 또는 현재 위치를 기준으로 현재 날씨를 알 수 있어야 한다.
  - Location LocationBloc.search(...?)
  - Weather WeatherBloc.fetchWether(Location)
- 날씨는 최근 3일 전 날씨, 3일 후 예보를 볼 수 있어야 한다.
  - Weather WeatherBloc.fetchWether().Last(3days)
  - Weather WeatherBloc.fetchWether().WithIn(3days)
- 앱에 진입하자마자 현재 날씨를 알 수 있어야 한다.
- 지역을 3개 이상 선택 혹은 검색할 수 있어야 한다.
  - AppBloc.addSearchedLocation(Location)
  - AppBloc.removeSearchedLocation(Location)
- 최근 조회한 지역을 알 수 있어야 한다.
  - AppBloc.setSearchLimit(Integer)
  - List<Location> AppBloc.getSearchedLocations()
- 비가 오는 날은 아침에 알림으로 알려주어야 한다.
  - WeatherBloc.alterChanges(Weather.Rainy)

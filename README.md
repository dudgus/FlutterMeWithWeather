# Flutter Me with Weather

레이어는 아래 처럼

- UI
- Domain
  - Models
  - UseCases
  - Repositories
- Data

## 우선은 필요한 로직을 요구사항을 기준으로 정리

requirements.md 를 기준으로 정리.

### Domain Logics - UseCases

- 사용자가 검색한 위치 또는 현재 위치를 기준으로 현재 날씨를 알 수 있어야 한다.
  - Location Location.search(...?)
  - Weather Weather.fetchWeather(Location)
- 날씨는 최근 3일 전 날씨, 3일 후 예보를 볼 수 있어야 한다.
  - List<Weather> Weather.fetchWether().Last(3days)
  - List<Weather> Weather.fetchWether().WithIn(3days)
- 앱에 진입하자마자 현재 날씨를 알 수 있어야 한다.
- 비가 오는 날은 아침에 알림으로 알려주어야 한다.
  - Time.getTime()
  - Weather.whenRainComes(...)
  - Weather.whenSnowComes(...)

### UI Logics

- 지역을 3개 이상 선택 혹은 검색할 수 있어야 한다.
  - AppCache.save<List<Location>>(String key, List<Location>)
  - AppCache.remove(String key)
  - AppCache.clear()
- 최근 조회한 지역을 알 수 있어야 한다.
  - List<Location> AppCache.get<List<Location>>(String key)

## Location & Weather Open API 사용

### 장소 (시, 구, 동) 이름을 사용해 위치 정보 얻기

Google Maps API - geocode

```
https://maps.googleapis.com/maps/api/geocode/json?language=ko&address=강남&key=[API_KEY]
```

### 장소 이름으로 오늘 날씨 & 날씨 예보 얻기

OpenWeatherMap API

```
http://api.openweathermap.org/data/2.5/weather?q=Gwonseon-gu&appid=[API_KEY]
http://api.openweathermap.org/data/2.5/forecast?q=Gwonseon-gu&appid=[API_KEY]
```

# Xplorer
Explorer for learning and find your X

## 目錄
* [專案目的](#專案目的)
* [User Story (Done)](#user-story-done)
* [User Story (In-Progress)](#user-story-in-progress)
* [Getting Started](#getting-started)
* [Built With](#built-with)
* [Authors](#authors)

## 專案目的
幫助學習者踏出學習的第一步：知識探索
#### 解決的問題
1. 知識探索時方向不容易建立，或是容易迷失。
2. 個人知識探索領域不易建立系統，跨領域探索無法有效發揮交叉價值。
#### 產品目標
1. 利用 Xplorer map 給予使用者各主題的熱門關聯領域，降低跨領域探索門檻。
2. 自動建立個人 Xplorer map，讓使用者在探索與學習中建立自己的知識系統。

## User Story (Done)
#### 使用者相關
1. 使用者可註冊/登入方式
    * Email (devise gem)
    * 第三方API: Google/Facebook帳號
2. 使用者個人檔案：
    * 可編輯資料：
      * 暱稱
      * 大頭照(carrierwave gem, 具上傳功能)
      * 自我介紹
      * 個人技能
    * 資料可設定他人觀看權限：
      * Email
      * 個人關注主題(Xmap)
      * 個人收藏議題
3. 使用者可以互相追蹤

#### 議題相關功能
1. 使用者登入後
    * 可以新增/編輯議題
      * 可自訂標題
      * 可自訂內容 (ckeditor gem, 編輯器支援)
        * Rich Text Editor(富文本編輯器)
        * 貼上影片連結時會自動嵌入
        * 可插入程式碼
        * 可上傳圖片
      * 可自訂主題標籤
        * 標籤欄位可輸入關鍵字搜尋主題
        * 標籤欄位可利用下拉選單直接選擇主題
      * 可定義議題狀態
        * 存成草稿
        * 發佈
    * 針對議題可以留言/分享/收藏/按讚
2. 可點擊議題標題導向議題瀏覽頁
3. 可點擊議題作者導向作者個人檔案頁
4. 未登入使用者可瀏覽議題及分享

#### 主題相關功能
1. 預設主題與主題間連結關係
2. 依據主題間連結關係產生Xplorer Map
   * 使用者能夠在 Xplorer Map 探索不同主題與了解學習領域關聯性
      * 提供不同擴展度的 Xplorer Map（一層擴展至三層擴展）
      * 為加速探索，提供熱門關聯主題推薦（同一時間最多提供四個關聯主題）
   * 點擊中心主題，進入主題頁與觀看相關議題
   * 點擊分支主題，改以該主題為中心繼續探索
   * 提供本次拜訪的探索履歷，讓使用者可以快速連結回前幾步的主題
3. 使用者登入後可以關注主題，建立個人的 X MAP
4. 為每位使用者繪製個人 X MAP，將個人關注的知識領域視覺化，以利使用者管理、調整個人的知識領域
5. 後台程式分析主題關聯度，以此微調與修正系統資訊
   * 紀錄使用者的 Xplorer Map 探索履歷
   * 分析使用者發布議題時加上的主題標籤
   * 依據使用者關注主題與進入主題頁次數，建立使用者對不同主題的關注度
   
#### 後台數據分析
1. 使用 Whenever 以 crontab 自動排程，定時分析

#### Landing Page
1. 可瀏覽top10熱門作者
2. 可瀏覽全網站熱門議題
3. 可瀏覽全網站熱門作者的議題
4. 依使用者登入狀態呈現不同內容
   * 登入前
      * 可瀏覽全網站關注度top5熱門主題
   * 登入後
      * 可瀏覽個人關注主題關注度top5
      * 可看到追蹤者的新議題
      * 可看到關注主題的新議題
5. 可在導覽列使用全站搜尋，結果依議題、主題、使用者分類
    
## User Story (In-Progress)
#### 使用者相關
1. 使用者註冊/登入優化  
    * 使用者註冊後，會收到註冊確認信
2. 通知功能
    * 新追隨者
    * 個人議題新留言/新回覆
    * 個人議題被讚/被收藏

#### 議題發表功能
1. 使用者登入後
    * 可自訂主題標籤
        * 標籤欄位未找到欲標籤之主題，可以自行新增

#### Onboarding
1. 未登入使用者進入首頁的引導頁面(功能完成待介面優化）

## Getting Started
#### Install project
```
$ bundle install
$ rails db:migrate
```
#### Setup data for development
```
$ rails demo:demo_all
```
#### Setup environment
Facebook/Google認證功能，需要取得Facebook/Google App ID和App Secret，
取得專屬App ID和App Secret後請創建`config/local_env.yml`，並在檔案中設定：
```
FB_APP_ID: 'YOUR_FB_APP_ID'
FB_SECRET: 'YOUR_FB_APP_SECRET'
GOOGLE_APP_ID: 'YOUR_GOOGLE_APP_ID'
GOOGLE_SECRET: 'YOUR_GOOGLE_APP_SECRET'
```
CKeditor的embed功能搭配[iframely](https://iframely.com/)的服務，需要申請自己的API KEY，
否則embed的媒體大小會有所限制，在iframely網址申請後，請至`config/local_env.yml`，並在檔案中設定：
```
IFRAMELY_LINK: '//iframe.ly/api/oembed?url={url}&callback={callback}&api_key=YOUR_API_KEY_HERE'
```
將YOUR_API_KEY_HERE換成自己的API KEY。

## Setup whenever
```
$ whenever --update-crontab
```

## Install Nokogirl
```
$ gem install nokogiri
```

## Built With
* Rails 5.2.1
* Authentication and OAuth: [Devise](https://github.com/plataformatec/devise), [Omniauth Facebook](https://github.com/mkdynamic/omniauth-facebook), [Omniauth Google Oauth2](https://github.com/zquestz/omniauth-google-oauth2)
* User Activity: [Ahoy](https://github.com/ankane/ahoy)
* Editor: [Ckeditor](https://github.com/galetahub/ckeditor)
* Pagination: [Kaminari](https://github.com/kaminari/kaminari)
* Uploader: [CarrierWave](https://github.com/carrierwaveuploader/carrierwave)
* HTTP client and tools: [REST Client](https://github.com/rest-client/rest-client)
* Testing data: [ffaker](https://github.com/ffaker/ffaker)
* Social Share: [Social Share Button](https://github.com/huacnlee/social-share-button)
* Layout: [Bootstrap 3](https://github.com/twbs/bootstrap-sass), [Bootswatch](https://github.com/maxim/bootswatch-rails), [D3.js](https://d3js.org/)
* Search: [Ransack](https://github.com/activerecord-hackery/ransack)
* Schedule: [Whenever](https://github.com/javan/whenever)
* HTML parser: [Nokogirl](http://www.nokogiri.org/)

## Authors
[Miki](https://github.com/miki770420)

[Wendy](https://github.com/wu790616)

[Yedda](https://github.com/yeddachuang)

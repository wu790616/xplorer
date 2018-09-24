# Xplorer
Explorer for learning and find your X

## 目錄
* [專案目的](#專案目的)
* [Getting Started](#getting-started)
* [User Story (Done)](#user-story-done)
* [User Story (In-Progress)](#user-story-in-progress)
* [Getting Started](#getting-started)

## 專案目的
#### 解決的問題
1. 學習時方向不容易建立，或是容易迷失。
2. 個人學習領域不易建立系統，跨領域學習無法有效發揮交叉價值。
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
1. 使用者登入後
    * 可以關注主題
2. 可點擊議題之主題標籤導向該主題之相關議題瀏覽頁
    
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
    
## User Story (In-Progress)
#### 使用者相關
1. 使用者註冊/登入優化  
    * 使用者註冊後，會收到註冊確認信
2. 通知功能
    * 新追隨者
    * 追蹤者新議題
    * 個人議題新留言/新回覆
    * 個人議題被讚/被分享/被收藏
    * 關注主題新議題

#### 議題發表功能
1. 使用者登入後
    * 可自訂主題標籤
        * 標籤欄位未找到欲標籤之主題，可以自行新增

#### Landing Page
1. 使用者可做全站搜尋

## Getting Started
#### install project
```
$ bundle install
$ rails db:migrate
```
#### Setup data for development
```
$ rails dev:fake_demo
```
#### Setup environment
Facebook/Google認證功能，需要取得Facebook/Google App ID和App Secret，並在專案中設定
取得專屬App ID和App Secret後請創建`config/local_env.yml`，並在檔案中設定：
```
FB_APP_ID: 'YOUR_FB_APP_ID'
FB_SECRET: 'YOUR_FB_APP_SECRET'
GOOGLE_APP_ID: 'YOUR_GOOGLE_APP_ID'
GOOGLE_SECRET: 'YOUR_GOOGLE_APP_SECRET'
```

## Built With
Rails 5.2.1

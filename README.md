# Xplorer
Explorer for learning and find your X

## 目錄
* [專案目的](#專案目的)
* [Getting Started](#getting-started)
* [User Story](#user-story)

## 專案目的
#### 解決的問題
1. 學習時方向不容易建立，或是容易迷失。
2. 個人學習領域不易建立系統，跨領域學習無法有效發揮交叉價值。
#### 產品目標
1. 利用 Xplorer map 給予使用者各主題的熱門關聯領域，降低跨領域探索門檻。
2. 自動建立個人 Xplorer map，讓使用者在探索與學習中建立自己的知識系統。

## User Story
#### 使用者相關
1. 使用者註冊/登入
    * 使用者可以輸入Email註冊登入
    * 使用者可以透過Google/Facebook帳號註冊登入  
    * 使用者註冊後，會收到註冊確認信(尚未開發)
2. 使用者可以編輯個人檔案：
    * 暱稱
    * 大頭照
    * 自我介紹
    * 個人技能
    * Email、個人關注主題(Xmap)、個人收藏議題的觀看權限
3. 使用者可以互相追蹤

#### 議題發表功能
1. 使用者登入後可以發表議題
    * 自訂標題、內容
    * 可在標籤欄位輸入關鍵字搜尋主題，或利用下拉選單直接選擇主題
    * 未找到欲標籤主題，可以自行新增(尚未開發 phase 2)
    * 儲存時可選擇要發佈，或是存成草稿
2. 編輯器支援
    * 採用Rich Text Editor(富文本編輯器)
    * 貼上youtube等連結時會自動嵌入
    * 支援圖片上傳
    * 支援插入程式碼(code)
    
## Getting Started
1. install project
```
$ bundle install
$ rails db:migrate
```
2. Setup fake data for development
```
$ rails dev:fake_all
```

## Built With
Rails 5.2.1

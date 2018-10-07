namespace :issue do

  # 假議題數量，隨時更新
  ISSUE_ALL = 21
  # 一個USER與議題互動的預設數量
  COMMENT_NUM = 5
  REPLY_NUM = 8

  # 產生假議題
  task demo_issue: :environment do
    Issue.destroy_all

    # 根據目前有幾篇假議題，決定create次數
    ISSUE_ALL.times do |i|
      Issue.create!(
        draft: "false",
        views_count: rand(1..300),
        edit_time: Time.now,
        user: User.all.sample
        )
    end
    puts "now you have #{Issue.count} issues data"
    puts "will add content....."

    # 為議題添入內容
    now = 1
    Issue.all.each do |issue|
      case now
        when 1
          issue.title = "什麼是蝴蝶效應？"
          issue.content = "<p><b>蝴蝶效應</b>&nbsp;(Butterfly effect) 是指在一個動態系統中，初始條件的微小變化，將能帶動整個系統長期且巨大的連鎖反應，是一種混沌的現象。「蝴蝶效應」在混沌學中也常出現。</p>\r\n\r\n<p>1961年冬天，美國氣象學家愛德華&middot;羅倫茲在使用電腦程式計算他所設計來模擬大氣中空氣流動的數學模型，在進行第二次計算時，想要省事，直接從程式的中段開始執行，並輸入前一次模擬結果列印出來的數據，計算出來的結果卻與第一次完全不同。經檢查後發現原因是出在列印的數據是0.506，精準度只有小數後3位，但該數據正確的值為0.506127，到小數後6位。</p>\r\n\r\n<p>1963年，羅倫茲發表論文「決定性的非週期流」（<i>Deterministic Nonperiodic Flow</i>），分析了這個效應。這篇論文後來被廣泛引用。<sup id=\"cite_ref-1\">[1]</sup><sup id=\"cite_ref-2\">[2]</sup>他也在另一篇期刊文章寫道，「一個氣象學家提及，如果這個理論被證明正確，一隻海鷗扇動翅膀足以永遠改變天氣變化。」<sup id=\"cite_ref-3\">[3]</sup>在以後的演講和論文中他用了更加有詩意的蝴蝶。對於這個效應最常見的闡述是「一隻蝴蝶在巴西輕拍翅膀，可以導致一個月後德克薩斯州的一場龍捲風。」</p>\r\n\r\n<p>「蝴蝶效應」是連鎖效應的其中一種，其意思即一件表面上看來毫無關係、非常微小的事情，可能帶來巨大的改變。此效應說明事物發展的結果，對初始條件具有極為敏感的依賴性，初始條件的改變，將會引起結果的極大差異。</p>\r\n\r\n<p style=\"text-align:center\"><img alt=\"art, Asian, blue\" height=\"411\" src=\"https://images.pexels.com/photos/114977/pexels-photo-114977.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"618\" /></p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E8%9D%B4%E8%9D%B6%E6%95%88%E5%BA%94\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E8%259D%25B4%25E8%259D%25B6%25E6%2595%2588%25E5%25BA%2594&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E8%259D%25B4%25E8%259D%25B6%25E6%2595%2588%25E5%25BA%2594\">蝴蝶效应</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n"
          topic_taged(issue, "科學")
          topic_taged(issue, "大氣科學")

        when 2
          issue.title = "實戰派成長"
          issue.content = "<section name=\"2880\">\r\n<p id=\"b265\" name=\"b265\">我人生中成長最快速的時期，都是在實戰的過程中累積的，反而不是在學校的讀書與考試，那些是累積知識的方法，這部分也絕對不可或缺，然而，要讓自己全盤通透，就得讓自己的知識與實戰完美融合。</p>\r\n\r\n<h3 id=\"9c7c\" name=\"9c7c\">不愛看書，也愛看書？</h3>\r\n\r\n<figure id=\"3ebd\" name=\"3ebd\">\r\n<p><canvas height=\"50\" width=\"75\"></canvas><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/1600/1*NNBZhCfqn2G_ieBf30LaaA.jpeg\" height=\"807\" src=\"https://cdn-images-1.medium.com/max/1600/1*NNBZhCfqn2G_ieBf30LaaA.jpeg\" width=\"1211\" /></p>\r\n</figure>\r\n\r\n<p id=\"e86e\" name=\"e86e\">「我不愛看書，也很愛看書」，這句話看似矛盾，卻是我成長的寫照，我不愛看書，是因為我從不喜歡為了考試而讀書；我喜歡讀書，是為了真正累積知識與應用於實際狀況上。紙上談兵難以吸引我，我比較喜歡實際跳下去操作，「實戰」這件事情，才有臨場感，你會真正受傷，也會真正成長。</p>\r\n\r\n<p id=\"add6\" name=\"add6\">如果你是學生，千萬不要被我誤導了，我的意思是，你可以不要因為考試而學習，但你必須認真學習，而且是要為了自己。</p>\r\n\r\n<h3 id=\"d5f3\" name=\"d5f3\">知識與實戰</h3>\r\n\r\n<p id=\"14fe\" name=\"14fe\">其實我現在看的書遠比學生時期還來得多太多，這是因為求知若渴，急迫於想要吸收更多資訊，是為了提升自己的知識，應用在真實的戰場上。在自己創業的過程中，實戰能力跳躍式成長，一般商業教科書其實無法完全照搬到實際狀況上，雖然可以作為參考，但是真正快速成長的原因在於每天所面臨的各種挑戰與困難，以及各種血淋淋的慘痛案例，對於企業家來說，他們直接面對的不是那些教科書上的試題，而是各種實際的策略執行、團隊管理、產品開發、財務預算與分析、風險管理、以及商業談判，這些都不是讀書就能夠解決的事，當你親自面對這些問題時，你才能掌握到這些細節的眉角，雖然必定遇到許多挫折，但是也因為經歷過風雨才能更加茁壯。</p>\r\n\r\n<h4 id=\"d06a\" name=\"d06a\">父親對我的榜樣</h4>\r\n\r\n<p id=\"02b6\" name=\"02b6\">我父親對我來說大概就是一個實戰派的榜樣，我常開玩笑說他真正唸的其實是社會大學，從小時候就看著他因為這些數不盡的實戰經驗，過關斬將，展現了他的高效能力，同時樂於助人的他，也獲得許多人們的尊敬，無論在策略、思想、法律、商業、風險、人際等各種領域，搭配著他雷厲風行的處事原則，讓他在面對各種事件的應對進退表現的游刃有餘，所有疑難雜症到他手裡都能夠處理的恰到好處。</p>\r\n\r\n<p id=\"6c0c\" name=\"6c0c\">之前有幾篇文章我都有提過，想要讓自己成長最快的方式，就是直接把自己放到戰場上，親自去體驗，你一定會想辦法讓自己存活下來，你也必須這麼做，在戰場上免不了挨刀，受傷是真實的，同時你也會從這些挫敗中重生，並且比以往更強大。</p>\r\n\r\n<h3 id=\"33e5\" name=\"33e5\">進入戰場前</h3>\r\n\r\n<figure id=\"684b\" name=\"684b\">\r\n<p><canvas height=\"46\" width=\"75\"></canvas><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/1600/1*qur0-Q4tG7xbuK_D2pDi6Q.jpeg\" height=\"574\" src=\"https://cdn-images-1.medium.com/max/1600/1*qur0-Q4tG7xbuK_D2pDi6Q.jpeg\" width=\"918\" /></p>\r\n</figure>\r\n\r\n<p id=\"2d14\" name=\"2d14\">等等，先別急著跳進戰場中！在戰場生存的原則就是不可無知與盲目，如果你連基本的知識都沒有，你要如何生存呢？</p>\r\n\r\n<p id=\"7796\" name=\"7796\">首先，你應該讓自己熱愛學習，擁抱新知，具備獨立思考的能力，不要不切實際的死讀書，實戰是為了讓自己接地氣，是為了讓知識與經驗結合，你可以循序漸進，如果你只有初級的實力，就別急著選擇地獄級的戰場，好好自我掂量一下，但是我會建議你應該挑戰中級的考驗，這樣才有成長的空間，學中做，做中學，相輔相成，自然會有所突破。</p>\r\n\r\n<p id=\"855e\" name=\"855e\">在實作中不會像學校讀書一樣，一切都顯得太夢幻、太美好，你會遭遇到許多無情的考驗，會有挫折，會有失敗，但是不要排斥，因為它們都是來成就你的，勇於接受挑戰，不要放棄努力，只有停止行動，才是真正失敗的開始，唯有堅持不懈，才能破繭而出，讓自己往上攀升至下一個等級！</p>\r\n\r\n<p id=\"fb92\" name=\"fb92\">不經一番寒徹骨，哪能&hellip;&hellip;，好了，太老套！心靈雞湯不用喝太多，熱身完畢，準備好就開始實戰吧！</p>\r\n</section>\r\n\r\n<section name=\"bcc0\">\r\n<hr />\r\n<blockquote id=\"31ee\" name=\"31ee\">如果你對我的文章有興趣，想要了解更多，以及關於LunaX與LunaLab，歡迎寫信給我（caelus315@gmail.com），我將一一回覆。</blockquote>\r\n\r\n<blockquote id=\"4a13\" name=\"4a13\">【關於LunaX】有鑒於學習的本質：解決問題與提升狀態，我們發展兩個教育品牌：LunaX與 LunaLab，LunaX為線上學習平台，LunaLab為專為孩子設計的課程實驗室，都是為了幫助人們學習，並提升解決問題的能力。</blockquote>\r\n\r\n<blockquote id=\"c082\" name=\"c082\">FB&nbsp;:&nbsp;<a data-href=\"https://www.facebook.com/lunax.lunalab/\" href=\"https://www.facebook.com/lunax.lunalab/\" rel=\"nofollow noopener nofollow noopener nofollow noopener nofollow noopener\" target=\"_blank\">https://www.facebook.com/lunax.lunalab/</a></blockquote>\r\n</section>\r\n"
          topic_taged(issue, "成長思維")
          topic_taged(issue, "激勵")
        
        when 3
          issue.title = "常聽到的股份有限公司是什麼？"
          issue.content = "<p style=\"text-align:center\"><img alt=\"15120, architecture, blue\" height=\"516\" src=\"https://images.pexels.com/photos/269077/pexels-photo-269077.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"774\" /></p>\r\n\r\n<p><b>股份公司</b>指由兩個或以上個體持有公司股票份額的企業組織形式。在股份公司的形式下，股份是企業組織（公司、合夥制企業）的所有權憑證。股份公司通過公開、非公開的方式發行股票，通過經營、投資、財務融資等方式創造利潤回報股東；而股東則可以出售手中股票，將代表自己對公司所有權的利益轉讓給其他人。近現代各國公司法都對股份公司的組織形式進行了界定，在法律學視角下，股份公司由於其法律定義和組織形式的特點，往往和「法人組織」、「有限責任」屬於同義詞，因此股份公司基本上是以股份有限公司的形式存在。但在一些法律上沒有界定「有限責任公司」的地區，股份公司也可以以無限責任公司的方式註冊。但在美國，無限責任公司依舊可以被稱視為股份公司的一種。</p>\r\n\r\n<h3>臺灣</h3>\r\n\r\n<p>依照中華民國法律，營利事業單位大致可分為「非法人」資格與「法人」資格。「非法人」資格是依《商業登記法》規定，分為「獨資」及「合夥組織」兩種；「法人」資格者依《公司法》規定，分為「無限公司」、「有限公司」、「兩合公司」及「股份有限公司」等四種。</p>\r\n\r\n<ol>\r\n\t<li>無限公司：指二人以上股東所組織，對公司債務負連帶無限清償責任之公司。</li>\r\n\t<li>有限公司：由一人以上股東所組織，就其出資額為限，對公司負其責任之公司。</li>\r\n\t<li>兩合公司：指一人以上無限責任股東，與一人以上有限責任股東所組織，其無限責任股東對公司債務負連帶無限清償責任；有限責任股東就其出資額為限，對公司負其責任之公司。</li>\r\n\t<li>股份有限公司：指二人以上股東或政府、法人股東一人所組織，全部資本分為股份；股東就其所認股份，對公司負其責任之公司。</li>\r\n</ol>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E8%2582%25A1%25E4%25BB%25BD%25E6%259C%2589%25E9%2599%2590%25E5%2585%25AC%25E5%258F%25B8&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E8%2582%25A1%25E4%25BB%25BD%25E6%259C%2589%25E9%2599%2590%25E5%2585%25AC%25E5%258F%25B8\">股份有限公司</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "商業")
          topic_taged(issue, "股份有限公司")

        when 4
          issue.title = "奧林匹克運動會的歷史"
          issue.content = "<p style=\"text-align:center\"><img alt=\"city, dawn, dusk\" height=\"522\" src=\"https://images.pexels.com/photos/236937/pexels-photo-236937.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"782\" /></p>\r\n\r\n<h2>古代奧林匹克運動會</h2>\r\n\r\n<p>根據希臘神話，大力神海克力斯在奧林匹亞贏得了一場比賽的勝利後下令，類似的比賽應該每四年在奧林匹亞舉行一次。另一個傳說則稱，宙斯在戰勝提坦巨人克洛諾斯後創立了奧林匹克運動會。但比較現實的說法是，在基督教的勢力還很薄弱時，另有一種信仰，名叫 自然崇拜 ，此信仰相信女人才是創世主，而代表女神之神維納斯的金星，也成為此信仰的標誌。他們發現，若每八年觀察一次，會發現這八年間，金星的軌道連起來會成為著名的五芒星，他們認為這是神的指示，所以就每八年舉辦一次運動會(無名)。而當此信仰消失後，在某個不可考的年代，當代領袖再次舉辦此運動會，並命名 奧林匹克。</p>\r\n\r\n<p>運動會是在祭神的奧林匹亞舉行，那裡有一個12米高的用象牙和黃金鑄成的宙斯神像，這個神像是世界七大奇蹟之一。</p>\r\n\r\n<p>第一個有文字記載的奧運會於公元前776年舉行，但是我們可以確定之前奧運會就已經存在了。當時只有短跑（希臘人稱之為「斯泰德」<i>Stadion</i>，意為「場地跑步」，英語中「體育場」<i>stadium</i>一詞就出於此）一個項目，長度為192.27米，因為這是大力神腳長的六百倍。奧運會每四年舉行一次，後來希臘人還將奧運會作為一種計算時間的方式，一個「奧林匹亞」就是兩次奧運會之間的時間&mdash;&mdash;4年。</p>\r\n\r\n<p>後來，其他項目逐漸地加入到奧運會中：拳擊、摔跤、古希臘式搏擊和田徑（包括場地跑、跳遠、標槍和鐵餅）。新項目的加入使得運動會的長度從1天延長到5天，其中3天有比賽，其他2天則從事宗教活動。最後一天所有的參賽選手都可以參加一場盛宴，享用在比賽第一天時供奉給宙斯的一百頭牛。奧運會項目獲勝者的獎品是橄欖枝編成的花環以及莫大的榮譽。雕塑家們還為獲勝者雕刻人像。古人曾經約定奧運會舉行期間，各城邦互不交戰，久而久之，橄欖枝就成了和平的象徵。因此奧運會雖然在現代是各國運動競技的項目，但主要的精神仍是以世界和平為主。</p>\r\n\r\n<p>但在393年，羅馬帝國皇帝狄奧多西一世廢除了古代奧林匹克會，認為這是一項「異教徒的活動」。</p>\r\n\r\n<h2>現代奧林匹克運動會</h2>\r\n\r\n<p>德國人庫齊烏斯花了多年時間挖掘古希臘的奧林匹亞村，他在1852年1月在柏林宣讀了考察報告，並建議恢復奧運會。</p>\r\n\r\n<p>被尊稱為「現代奧林匹克之父」的法國教育家皮埃爾&middot;德&middot;顧拜旦於1892年在索邦大學把範圍擴大到全世界。1894年，顧拜旦致函各國體育組織，邀請他們參加在巴黎舉行的國際體育大會。在同年6月16日舉行12國的代表在巴黎舉行了「恢復奧林匹克運動大會」。會議決議每四年舉行一次全球範圍的奧林匹克運動會。6月23日，國際奧林匹克委員會成立，希臘人澤麥特里烏斯&middot;維凱拉斯出任主席，顧拜旦任秘書長，並親自設計了奧運會的會徽、會旗。會議還通過了奧林匹克憲章。1896年，第一屆現代奧林匹克運動會終於在希臘雅典正式舉行。並決定此後每4年舉行一次，會期不超過16天。</p>\r\n\r\n<p>歷屆奧運會從1896年開始，每4年舉辦一次，其中第6屆（1916年）、第12屆（1940年）、第13屆（1944年）由於戰爭的原因沒有舉行，但是屆數仍然按照順序排列。</p>\r\n\r\n<div class=\"embed-240p\" data-oembed-url=\"https://zh.wikipedia.org/wiki/%E5%A5%A5%E6%9E%97%E5%8C%B9%E5%85%8B%E8%BF%90%E5%8A%A8%E4%BC%9A\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"padding-bottom: 46.1659%; padding-top: 120px;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E5%25A5%25A5%25E6%259E%2597%25E5%258C%25B9%25E5%2585%258B%25E8%25BF%2590%25E5%258A%25A8%25E4%25BC%259A&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E5%25A5%25A5%25E6%259E%2597%25E5%258C%25B9%25E5%2585%258B%25E8%25BF%2590%25E5%258A%25A8%25E4%25BC%259A\">奥林匹克运动会</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "運動")
          topic_taged(issue, "奧林匹克")

        when 5
          issue.title = "聽過翻轉課堂嗎？"
          issue.content = "<p><img alt=\"Man Beside Flat Screen Television With Photos Background\" height=\"450\" src=\"https://images.pexels.com/photos/716276/pexels-photo-716276.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"674\" /></p>\r\n\r\n<p><b>翻轉課堂</b>（英語：Flipped classroom），又譯為<b>翻轉教室</b>、<b>顛倒教室</b>，是一種新的教學模式，2007年起源於美國<sup id=\"cite_ref-fju_1-0\">[1]</sup>，翻轉課堂會先由學生在家中看老師或其他人準備的課程內容，到學校時，學生和老師一起完成作業，並且進行問題及討論。由於學生及老師的角色對調，而在家學習，在學校完成作業的方式也和傳統教學不同，因此稱為「翻轉課堂」<sup id=\"cite_ref-2\">[2]</sup>。</p>\r\n\r\n<p>隨著時代的演進，各國教育逐漸朝向以「教師」及「學生」為主體的方向發展，課程與教學的意義也隨之轉變。雖然在狹義的「翻轉教室」定義中，影片是個重要元素，但隨著「翻轉」的概念不斷延伸，討論也從「教學流程」進展到「教育價值觀」層面。</p>\r\n\r\n<p>如目前使用率極高的免費教學資源網站「可汗學院」、以及大規模線上開放課程的三大巨頭Coursera、Udacity和edX，即顛覆過去傳統的學習方式&mdash;教師在教室中教學，學生聽講之後再回家練習&mdash;而是學生自行在家就可以看影片就可以「上課」，由學生主動掌控和參與學習。</p>\r\n\r\n<p>翻轉教室目前普遍的核心概念大致包括：扭轉過去課堂上純粹「老師說、學生聽」的單向填鴨，轉而重視「以學生學習為中心」的教學，把學習的發球權還到孩子手上；更看重啟發學生學習動機，幫助學生建構自主學習能力，並認同多元評量與多元價值。誠致教育基金會董事長方新舟曾歸納翻轉教學的關鍵有三：第一是把學習主體還給學生，第二是讓天賦自由，第三是因材施教。</p>\r\n\r\n<p>如今，「翻轉」概念的影響力仍不斷擴大中。「讓學生先看影片」成為其中一種方法，但許多教學法也都開始吸納翻轉的精神，透過轉化與在地化，以老師認為最適合自己班上學生的方式，造就「以學習者為中心」的課堂風貌。</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E7%BF%BB%E8%BD%AC%E8%AF%BE%E5%A0%82\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E7%25BF%25BB%25E8%25BD%25AC%25E8%25AF%25BE%25E5%25A0%2582&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E7%25BF%25BB%25E8%25BD%25AC%25E8%25AF%25BE%25E5%25A0%2582\">翻转课堂</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "教育")
          topic_taged(issue, "翻轉教育")

        when 6
          issue.title = "科學的含義"
          issue.content = "<p style=\"text-align:center\"><img alt=\"Close-up of Drinking Glass\" height=\"369\" src=\"https://images.pexels.com/photos/248152/pexels-photo-248152.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"553\" /></p>\r\n\r\n<p>「科學」不好以簡短文字加以準確定義。一般說來，科學涵蓋三方面含義：</p>\r\n\r\n<ol>\r\n\t<li>觀察：致力於揭示自然真相，而對自然作用由充分的觀察或研究（包括思想實驗），通常指可通過必要的方法進行的，或能通過科學方法&mdash;&mdash;一套用以評價經驗知識的程序而進行的。</li>\r\n\t<li>假設：通過這樣的過程假定組織體系知識的系統性。</li>\r\n\t<li>檢證：藉此驗證研究目標的信度與效度。</li>\r\n</ol>\r\n\r\n<p>科學包括基礎科學與應用科學。基礎科學僅以通過試驗探究自然原理為目的，其成果一般不容易在短期內得到應用，如物理、化學、生物和地質學；應用科學則兼有探究原理與關注應用這兩個方面的動機，如醫學、藥學、應用光學、氣象學、科技考古學和博弈論。按理來說，科學不同於純技術類學科，後者只涉及運用已有的知識與原理進行發明創造，而只帶來技術變革，不在原理層次挖掘出的新規律，如工程學、法醫學、農學和林學。應用科學與純技術有時候很難界定。因科學與技術經常一起被提及，重要的技術發展有時也會被大眾視為是科學成就，例如袁隆平曾3次未評上中國科學院院士的一大理由就是雜交水稻在科學界常只被認為是工程學成就，而非科學成就。<sup id=\"cite_ref-1\">[1]</sup>大眾關於愛迪生算不算科學家的爭論也與之類似。一些學科是側重基礎研究還是側重應用研究可能會隨時間發展而變動。如天文學的前身占星學是為宗教儀式服務的，屬於應用類學科（當時還不算是科學）；天文學目前是以基礎研究為主的科學，但也有發射宇宙衛星等少數可帶來實質性服務（如電台廣播與手機信號）的技術應用；天文學在實現星際移民與太空資源開發的未來可能又會變成以應用為主的學科。</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E7%A7%91%E5%AD%A6\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E7%25A7%2591%25E5%25AD%25A6&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E7%25A7%2591%25E5%25AD%25A6\">科学</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "科學")

        when 7
          issue.title = "生活的意義"
          issue.content = "<p><img alt=\"Green Car Near Seashore With Blue Ocean\" height=\"216\" src=\"https://images.pexels.com/photos/1118448/pexels-photo-1118448.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"328\" /></p>\r\n\r\n<p>不同人對生活的意義有不同的看法，取決於個人的思想、愛好等。</p>\r\n\r\n<p>歷史學家呂思勉認為，人生在世，除掉極庸碌之輩，總有一個志願。志願而做到，就是成功、快樂。志願而做不到，看似失敗，然而自己心力已盡，也覺得無所愧怍，也是快樂。志願各人不同，似乎很難比較。然而其人物愈大，則其志願愈大，為人成分愈多，自為成分愈少，則是一定不移。<sup id=\"cite_ref-史話_1-4\">[1]</sup><sup>:135</sup>哪有蓋世英雄之志願只為自己為子孫；說此話正見他自己是個小人，所以燕雀不知鴻鵠之志。</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E7%94%9F%E6%B4%BB\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E7%2594%259F%25E6%25B4%25BB&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E7%2594%259F%25E6%25B4%25BB\">生活</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "生活")

        when 8
          issue.title = "尋找真正的自己"
          issue.content = "<section name=\"b931\">\r\n<figure id=\"496c\" name=\"496c\">\r\n<p><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/800/1*qbnrufLb_G0vC63i4FAKiA.jpeg\" src=\"https://cdn-images-1.medium.com/max/800/1*qbnrufLb_G0vC63i4FAKiA.jpeg\" /></p>\r\n</figure>\r\n\r\n<p id=\"c4d6\" name=\"c4d6\">你有多久沒有為了自己奮鬥？有多久沒有為了自己努力？有多久沒有為了自己而學習？有多久沒有為了自己而成長？我們做了多少事，但是卻忘記我們原來的初衷？</p>\r\n\r\n<p id=\"3431\" name=\"3431\">我想對於許多人來說，生活不會只想剩下上班工作，不會只是玩樂、麻痹自己的知覺，不會只想要把生命一點一滴浪費掉。然而，我們卻可能在不知不覺中，忘記好好地做自己，沒有好好傾聽自己內心的聲音。</p>\r\n\r\n<p id=\"972f\" name=\"972f\">當然，不要把「做自己」給搞混了，不是為所欲為就是做自己，而是去尋找心中真正的源頭，你真正在乎的是什麼？真正要創造的人生價值會是什麼？想要追求的目標是什麼？</p>\r\n\r\n<p id=\"d4dd\" name=\"d4dd\">無論我們處在什麼年齡、身份、地位，都要清楚自己在做什麼，不要盲目，否則會失去自我。身為學生不要只是為了考試競爭而學習，真正的學習是為了自己，而不是為了贏得第一；身為父母不要為了跟別的孩子比較，而讓孩子變成魁儡，每個孩子都是獨一無二，要去發掘他們的天份與意識；工作不要只是一種交差，而是理解價值，做對自己真正有意義的工作，如果你找不到價值，那就代表你在浪費時間；打工遊學也很好，但是不要只是蜻蜓點水，不要以為換個環境、換個工作，人生就會不一樣，思維沒變，什麼都不會變，真正開拓眼界是要深入，而不只是體驗。</p>\r\n\r\n<p id=\"7e71\" name=\"7e71\">我們都曾迷失過，包括我自己，迷失的原因都是來自於失去自我、忘記自己在乎的、要解決的、要追求的，因此挫折一來就很容易自我懷疑。要找到自己的價值與目標，這是一種尋找自我的過程，如此才會知道自己在做什麼，即使工作量再大、考驗再多，也讓我們不至於失去方向。</p>\r\n\r\n<p id=\"6e22\" name=\"6e22\">很重要的關鍵在於保持一致，卻又充滿彈性。一致的是你的初衷、你追求的價值、你的人生目標；彈性則是發揮在過程中，你可以有無限的變化，但是永遠圍繞著你的內在本源。</p>\r\n\r\n<p id=\"d0a8\" name=\"d0a8\">或許我們應該回想，跟別人競爭拿第一是自己的初衷嗎？讓孩子比別的孩子更會考試是自己的初衷嗎？交差了事是自己的初衷嗎？出國打工體驗是自己的初衷嗎？如果都不是，那就必須去找出來。你可以把考試、競爭、交差、體驗都當成一種達到目的的手段，但是你必須清楚你真正內心的人生目標會是什麼。</p>\r\n\r\n<blockquote id=\"513b\" name=\"513b\">Be, don&rsquo;t try to become. &mdash; Osho</blockquote>\r\n\r\n<figure id=\"70f2\" name=\"70f2\">\r\n<p><canvas height=\"47\" width=\"75\"></canvas><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/800/1*D4WP6RAOjhZdz5fsWRFP4w.jpeg\" src=\"https://cdn-images-1.medium.com/max/800/1*D4WP6RAOjhZdz5fsWRFP4w.jpeg\" /></p>\r\n</figure>\r\n\r\n<p id=\"a9d9\" name=\"a9d9\">Be yourself， 在這之前你必須找到真正的自我，這是經過許多考驗的洗禮，而你不能放棄自我的意識，這種意識是開放性的，具有可塑性、可成長的，而不是封閉式的自大與自滿，也不是填鴨式的盲目與跟從。Don&rsquo;t try to become，是要做好自己，而不是「Try to become someone」，你就是你，不要忘記你是誰，找出自己的價值，並且勇往直前。</p>\r\n</section>\r\n\r\n<section name=\"5bb4\">\r\n<hr />\r\n<blockquote id=\"53e9\" name=\"53e9\">如果你對我的文章有興趣，想要了解更多，以及關於LunaX與LunaLab，歡迎寫信給我（caelus315@gmail.com），我將一一回覆。</blockquote>\r\n\r\n<blockquote id=\"4a13\" name=\"4a13\">【關於LunaX】有鑒於學習的本質：解決問題與提升狀態，我們發展兩個教育品牌：LunaX與 LunaLab，LunaX為線上學習平台，LunaLab為專為孩子設計的課程實驗室，都是為了幫助人們學習，並提升解決問題的能力。</blockquote>\r\n\r\n<blockquote id=\"1e54\" name=\"1e54\">FB&nbsp;:&nbsp;<a data-href=\"https://www.facebook.com/lunax.lunalab/\" href=\"https://www.facebook.com/lunax.lunalab/\" rel=\"nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener\" target=\"_blank\">https://www.facebook.com/lunax.lunalab/</a></blockquote>\r\n</section>\r\n"
          topic_taged(issue, "成長思維")

        when 9
          issue.title = "你聽過無限公司嗎？"
          issue.content = "<p><img alt=\"architectural design, architecture, building\" height=\"320\" src=\"https://images.pexels.com/photos/443383/pexels-photo-443383.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"427\" /></p>\r\n\r\n<p><b>無限公司</b>（英語：<b>General partnership</b>，日語：<b>合名会社</b><sup id=\"cite_ref-1\">[1]</sup>），中華民國公司法四種公司之一。指依法註冊成立的公司或法人型態之一。該公司型態最大特點在於公司股東對公司債務負無限責任。</p>\r\n\r\n<p>無限公司亦分無股份劃分之無限公司及有股份劃分的無限公司，不過股份劃分並不影響股東對公司承擔的責任。因承擔責任風險等因素，今以無限公司型態成立的商業團體並不普遍。<sup id=\"cite_ref-2\">[2]</sup></p>\r\n\r\n<p>依據中華民國公司法第二章第40條規定，無限公司須由二人以上之股東所組織，其中至少一人要在中華民國境內有住所，設立後如股東變動，不足二人時，該無限公司即須解散。</p>\r\n\r\n<p>開設無限責任公司通常較快捷，且成本較低。不過，無限責任公司需要向稅局登記，並要備存足夠的業務記錄最少7年。壞處是無限責任。如果無限公司虧損或欠債，公司東主或負責人要承擔所有責項，亦可能因此而破產。</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E7%84%A1%E9%99%90%E5%85%AC%E5%8F%B8\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E7%2584%25A1%25E9%2599%2590%25E5%2585%25AC%25E5%258F%25B8&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E7%2584%25A1%25E9%2599%2590%25E5%2585%25AC%25E5%258F%25B8\">無限公司</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "商業")
          topic_taged(issue, "無限公司")

        when 10
          issue.title = "田徑項目概述"
          issue.content = "<p><img alt=\"asphalt, athletics, blur\" height=\"408\" src=\"https://images.pexels.com/photos/401896/pexels-photo-401896.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"611\" /></p>\r\n\r\n<ul>\r\n\t<li>田賽可分為跳躍、投擲兩類項目\r\n\t<ul>\r\n\t\t<li>跳躍，包括跳高、撐竿跳高、跳遠、三級跳；</li>\r\n\t\t<li>投擲，包括推鉛球、擲鐵餅、擲標槍、擲鏈球</li>\r\n\t</ul>\r\n\t</li>\r\n\t<li>徑賽，可分為短跑、中跑、長跑、接力跑、跨欄和障礙跑；</li>\r\n\t<li>公路跑，必須在公路上進行，有各種距離的公路跑和公路接力跑，包括半程馬拉松、馬拉松等；</li>\r\n\t<li>競走，均可在體育場內或場外進行；</li>\r\n\t<li>越野賽跑，必須在原野、草地等自然環境中進行。</li>\r\n</ul>\r\n\r\n<div class=\"embed-240p\" data-oembed-url=\"https://zh.wikipedia.org/wiki/%E7%94%B0%E5%BE%84\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"padding-bottom: 80.4182%; padding-top: 120px;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E7%2594%25B0%25E5%25BE%2584&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E7%2594%25B0%25E5%25BE%2584\">田径</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "運動")
          topic_taged(issue, "田徑")

        when 11
          issue.title = "家庭教育的影響"
          issue.content = "<p><img alt=\"Man Standing Beside His Wife Teaching Their Child How to Ride Bicycle\" height=\"391\" src=\"https://images.pexels.com/photos/1128318/pexels-photo-1128318.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"494\" /></p>\r\n\r\n<p>家庭是每個人最早接觸的團體，因此家庭教育是非常重要，父母給予孩子正確的教導，孩子自然能夠成為有品德的人，若父母不理會孩子的教育發展，孩子可能會因而學壞。家庭教育隨時都存在，家人對每個人的影響深大，言行舉止；帶給人的感覺都和家庭有深大的關係，因此不只是從小開始的教育，更要在平常時給孩子灌輸正確的觀念。</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E5%AE%B6%E5%BA%AD%E6%95%99%E8%82%B2\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E5%25AE%25B6%25E5%25BA%25AD%25E6%2595%2599%25E8%2582%25B2&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E5%25AE%25B6%25E5%25BA%25AD%25E6%2595%2599%25E8%2582%25B2\">家庭教育</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "教育")
          topic_taged(issue, "家庭教育")

        when 12
          issue.title = "福衛五號"
          issue.content = "<p><img alt=\"Yellow Flag on Boat\" height=\"261\" src=\"https://images.pexels.com/photos/256379/pexels-photo-256379.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"268\" /></p>\r\n\r\n<p><b>福爾摩沙衛星五號</b>（英語：<b>FORMOSAT-5</b>，縮寫為<b>FS-5</b>，簡稱<b>福衛五號</b>或<b>福五</b>）是臺灣的太陽同步軌道衛星，亦為首個由臺灣完全自主研發的光學遙測衛星及第四個自主擁有的人造衛星；屬於中華民國國家太空中心第二期太空科技發展長程計畫的「遙測衛星計畫」中，繼福衛四號之後的第二個衛星計畫。任務著重於衛星本體及光學遙測與科學酬載自主能力的建立，並接替於2016年除役的福衛二號任務。福衛五號是一顆僅作為商業性用途的衛星，其拍攝照片不用於軍事。</p>\r\n\r\n<div class=\"embed-240p\" data-oembed-url=\"https://zh.wikipedia.org/wiki/%E7%A6%8F%E7%88%BE%E6%91%A9%E6%B2%99%E8%A1%9B%E6%98%9F%E4%BA%94%E8%99%9F\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"padding-bottom: 62.4181%; padding-top: 120px;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E7%25A6%258F%25E7%2588%25BE%25E6%2591%25A9%25E6%25B2%2599%25E8%25A1%259B%25E6%2598%259F%25E4%25BA%2594%25E8%2599%259F&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E7%25A6%258F%25E7%2588%25BE%25E6%2591%25A9%25E6%25B2%2599%25E8%25A1%259B%25E6%2598%259F%25E4%25BA%2594%25E8%2599%259F\">福爾摩沙衛星五號</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "科學")
          topic_taged(issue, "航太工程")

        when 13
          issue.title = "讓自己準備好"
          issue.content = "<section name=\"052a\">\r\n<p id=\"1337\" name=\"1337\">機會就在前面，你打算怎麼做？有時我們會想要讓自己準備好再去爭取，但其實永遠都沒有真正準備好的一天，應該說，如果你是個上進的人，那麼今天的你永遠都會比昨天更好，而如果你還無法跨出去這一步，那麼問題不在於實力，而在於你該學習如何讓自己保持準備好的狀態。</p>\r\n\r\n<h3 id=\"5ee2\" name=\"5ee2\">思維上的準備</h3>\r\n\r\n<figure id=\"aaf5\" name=\"aaf5\">\r\n<p><canvas height=\"47\" width=\"75\"></canvas><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/800/1*9HTQ2_fqZwoYYWZF3D3VKw.jpeg\" src=\"https://cdn-images-1.medium.com/max/800/1*9HTQ2_fqZwoYYWZF3D3VKw.jpeg\" /></p>\r\n</figure>\r\n\r\n<p id=\"e87d\" name=\"e87d\">想辦法讓自己隨時處在準備好的狀態，第一個就是思維，永遠都要清楚自己在做什麼，要知道自己追求的是什麼，你越了解自己，就越能夠做出正確的判斷。隨時檢視自己的目標，看自己是否正在軌道上，不偏離初心。</p>\r\n\r\n<p id=\"b8c6\" name=\"b8c6\">如果你不知道自己想要的是什麼，那代表你還在追尋自我的過程中，這也無妨，你該做的就是不斷嘗試，找到自己真正所熱愛，不要停止努力，因為只要停下來，你就處在迷失的狀態，這不是好現象，你必須努力找到真正的自己，你的人生才開始散發真正的價值。</p>\r\n\r\n<h3 id=\"67c7\" name=\"67c7\">實力上的準備</h3>\r\n\r\n<figure id=\"bbee\" name=\"bbee\">\r\n<p><canvas height=\"40\" width=\"75\"></canvas><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/800/1*1dw2h24FeV0rI0IrmFFmFQ.jpeg\" src=\"https://cdn-images-1.medium.com/max/800/1*1dw2h24FeV0rI0IrmFFmFQ.jpeg\" /></p>\r\n</figure>\r\n\r\n<p id=\"74f3\" name=\"74f3\">隨時提升自我，你必須敞開心胸，讓自己不斷學習成長，除此之外，最好的成長機會就是直接把自己丟到戰場上，經過實戰的磨練之後，你會脫胎換骨，這種速度是驚人的，你會訝異於自己進步的神速，你的知識將在各種實際工作中發揮的淋漓盡致，以此累積更多經驗，當你身經百戰，你的智慧與實戰將取得更完美的平衡。</p>\r\n\r\n<p id=\"2f70\" name=\"2f70\">我自己特別崇尚實戰派成長，或許受到父親的影響，他在我的生命中就是扮演著一個實戰派的代表人物，也感恩有非常多的考驗與挫折來磨練自己，把自己放到江湖中，必定會挨刀，也必定會成長，不要放棄讓自己蛻變的機會，學習、實戰、學習、實戰，你的實力自然慢慢養成。</p>\r\n\r\n<h3 id=\"3539\" name=\"3539\">心態上的準備</h3>\r\n\r\n<p id=\"90fd\" name=\"90fd\">保持急迫感，急迫於想追求人生的目標、創造人生的價值，你必須勇敢，勇於跨出每一步、接受每一個未知的挑戰、把握每一個機會與當下，如果這些你都不具備，或許你是因為害怕未知、害怕改變、害怕付出沒有收穫、害怕失敗、害怕挫折，或即便只是僅僅不想跨出自己的舒適圈，你都會需要一件事，那就是一個低谷。</p>\r\n\r\n<figure id=\"061c\" name=\"061c\">\r\n<p><canvas height=\"47\" width=\"75\"></canvas><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/800/1*O8Qr5wAYdm4bhdZSJ-wXeQ.jpeg\" src=\"https://cdn-images-1.medium.com/max/800/1*O8Qr5wAYdm4bhdZSJ-wXeQ.jpeg\" /></p>\r\n</figure>\r\n\r\n<p id=\"4a27\" name=\"4a27\">只有面臨低谷，你才會無所失去，才會知道再也沒有更苦的事、再也沒有更值得害怕的事、你已沒有更多可以損失，只有低谷，你才有反彈的餘地，才會急迫地想改變點什麼、認真思考自己所追求的真實意義、思索人生真正的價值，開始勇敢、無所畏懼，你會告訴自己：「有什麼好怕？再困難的都已經過去，未來只會更好！」</p>\r\n\r\n<p id=\"61d4\" name=\"61d4\">因此低谷是一種恩賜，是上天給予自己的考驗，也是一種機會，把握它，你就會找到出口。如果你沒遇到低谷，那麼你該慶幸，更應該謙虛，更不該自我放逐，既然有了比他人更好的起點，何不好好把握？</p>\r\n\r\n<p id=\"151a\" name=\"151a\">讓自己隨時準備好，機會不會為你留下，你必須自己爭取，所謂狼性，指的就是保持飢餓，飢餓於機會、飢餓於目標、飢餓於人生的價值、飢餓於自我的學習、飢餓於自我的成長，專注地往上爬，專注地為自己、為團體、為社會創造更大的價值。</p>\r\n</section>\r\n\r\n<section name=\"8884\">\r\n<hr />\r\n<blockquote id=\"2d43\" name=\"2d43\">如果你對我的文章有興趣，想要了解更多，以及關於LunaX與LunaLab，歡迎寫信給我（caelus315@gmail.com），我將一一回覆。</blockquote>\r\n\r\n<blockquote id=\"4a13\" name=\"4a13\">【關於LunaX】有鑒於學習的本質：解決問題與提升狀態，我們發展兩個教育品牌：LunaX與 LunaLab，LunaX為線上學習平台，LunaLab為專為孩子設計的課程實驗室，都是為了幫助人們學習，並提升解決問題的能力。</blockquote>\r\n\r\n<blockquote id=\"1e54\" name=\"1e54\">FB&nbsp;:&nbsp;<a data-href=\"https://www.facebook.com/lunax.lunalab/\" href=\"https://www.facebook.com/lunax.lunalab/\" rel=\"nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener nofollow noopener\" target=\"_blank\">https://www.facebook.com/lunax.lunalab/</a></blockquote>\r\n</section>\r\n"
          topic_taged(issue, "成長思維")

        when 14
          issue.title = "智慧財產權"
          issue.content = "<p><img alt=\"architect, architectural design, architecture\" height=\"339\" src=\"https://images.pexels.com/photos/595847/pexels-photo-595847.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"508\" /><br />\r\n<b>智慧財產</b>（英語：Intellectual Property），是人類智慧創造出來的無形的財產，主要涉及版權、專利、商標等領域。<sup id=\"cite_ref-1\">[1]</sup>&nbsp;音樂和文學等形式的藝術作品，以及一些發現、發明、詞語、詞組、符號、設計都能被當作智慧財產而受到保護。<sup id=\"cite_ref-2\">[2]</sup><sup id=\"cite_ref-3\">[3]</sup>&nbsp;智慧財產權可以分為工業產權與版權兩類，工業產權包括發明（專利）、商標、工業品外觀設計和地理標誌，版權則包括文學和藝術作品。<sup id=\"cite_ref-WIPO_4-0\">[4]</sup></p>\r\n\r\n<p>智慧財產權被概括為一切來自知識活動領域的權利，始於17世紀中葉法國學者卡普佐夫的著作，後由比利時法學家皮爾第所發展；到1967年《成立世界智慧財產權組織公約》簽訂後，智慧財產權的概念得到世界上大多數國家所認可。</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E7%9F%A5%E8%AF%86%E8%B4%A2%E4%BA%A7\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E7%259F%25A5%25E8%25AF%2586%25E8%25B4%25A2%25E4%25BA%25A7&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E7%259F%25A5%25E8%25AF%2586%25E8%25B4%25A2%25E4%25BA%25A7\">知识财产</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "商業")
          topic_taged(issue, "智慧財產權")

        when 15
          issue.title = "壓力"
          issue.content = "<p><img alt=\"adult, blur, books\" height=\"266\" src=\"https://images.pexels.com/photos/261909/pexels-photo-261909.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"372\" /><br />\r\n<b>壓力</b>是一個心理學與生物學的術語，意指人類或動物面對情緒上或身體上的有形或無形威脅時，無法正常回應的感受狀態。該名詞首次出現於1930年代的生物學研究領域裡，近年來已逐漸為大眾所熟知。</p>\r\n\r\n<p>適當的壓力可能提高人的警覺性，使其更小心思考，謹慎行事，從而發揮更理想的表現。過度的壓力則會使其困擾、沮喪和氣餒，引致腎上腺素增多，失去自控能力，影響身體健康。壓力包括三部分：</p>\r\n\r\n<ol>\r\n\t<li>壓力源即對我們產生壓力的事物和處境；</li>\r\n\t<li>壓力源會產生壓力感，壓力感的大小取決於個人對壓力源的重視程度，對有關事物和處境的管理控制能力，以及對自己的期望：</li>\r\n\t<li>不同程度的壓力感，會引致不同的壓力反應，並在生理、心理、認知、情緒等方面表現出來。</li>\r\n</ol>\r\n\r\n<p>真正、或自以為是具威脅性的事件時所激發起來的一種身心不安、緊張、焦慮、苦惱和逼迫的感受狀態。當要求高、限制多而支援少時，即會造成當事者的壓力。它與客觀問題有關。固此，應付壓力之時，最好先瞭解造成壓力的主觀因素和客觀條件分別是什麼。<b>壓力來源是指個人和群體的特性與期望、組織特性和工作環境與工作特性。</b>&nbsp;紓解壓力的方式有以下這幾種：視訊，拍照，講電話，泡澡，聊天......等許多方式<br />\r\n&nbsp;</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E5%A3%93%E5%8A%9B_(%E9%86%AB%E5%AD%B8)\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E5%25A3%2593%25E5%258A%259B_(%25E9%2586%25AB%25E5%25AD%25B8)&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E5%25A3%2593%25E5%258A%259B_(%25E9%2586%25AB%25E5%25AD%25B8)\">壓力 (醫學)</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "生活")                             
          topic_taged(issue, "壓力")

        when 16
          issue.title = "什麼是越位？"
          issue.content = "<p><img alt=\"action, ball, field\" height=\"289\" src=\"https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"434\" /></p>\r\n\r\n<p>一球員是不是在<b>越位位置</b>上，由兩個條件決定，即<b>球的位置</b>及<b>對方站在最後第二位的球員位置</b>(注:因為對方陣營之最後位置的球員「通常」是守門員，所以越位線其中一個條件必然是對方站在<b>最後第二</b>位的球員位置)。當球員所在的位置比「<b>球</b>和<b>站在最後第二位的對方球員</b>更靠近對方底線」，就處於<b>越位位置</b>。但若此球員處於本方半場內，則不受此限制。如果球員和第二名對方球員平行，亦不算越位。</p>\r\n\r\n<p>球員處於越位位置，且在球被隊友接觸到或者拿到的時候，他被裁判員認定為<b>涉入進行中的比賽</b>，才會構成<b>越位違例</b>。所謂<b>涉入進行中的比賽</b>指影響比賽、影響對方球員以及通過處於該位置獲益。</p>\r\n\r\n<p>如果球員是通過界外球、球門球或者角球接到的球，不屬于越位違例。</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E8%B6%8A%E4%BD%8D_(%E8%B6%B3%E7%90%83)\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E8%25B6%258A%25E4%25BD%258D_(%25E8%25B6%25B3%25E7%2590%2583)&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E8%25B6%258A%25E4%25BD%258D_(%25E8%25B6%25B3%25E7%2590%2583)\">越位 (足球)</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "運動")
          topic_taged(issue, "球類運動")

        when 17
          issue.title = "博物館的起源"
          issue.content = "<p><img alt=\"\" height=\"260\" src=\"https://images.pexels.com/photos/69903/pexels-photo-69903.jpeg?auto=compress&amp;cs=tinysrgb&amp;dpr=2&amp;h=650&amp;w=940\" width=\"390\" /></p>\r\n\r\n<p>博物館的起源，是於約公元前300年亞歷山卓的繆斯（Musaeum）。繆斯中專門收藏了古希臘的亞歷山大大帝在歐洲、亞洲及非洲的征戰得到的珍品。博物館的英文「Museum」，就是源於希臘語的繆斯「&Mu;&omicron;&upsilon;&sigma;&epsilon;ῖ&omicron;&nu;」。然而，當時的博物館並不對外開放。</p>\r\n\r\n<p>文藝復興時期，歐洲的王室貴族開始於王宮中設陳列室收藏珍品，但亦只開放給貴族參觀。早期的博物館始於富裕的個人、家庭或藝術機構的私人收藏品，包括稀有或令人好奇的自然物件和文物。這些東西往往擺設在所謂的奇觀房或搜奇櫃。其他大眾接觸這些蒐藏品，往往只有是「有頭有臉的人」才有機會，特別是私人藝術收藏，但這是依據主人及其工作人員的意願而定。</p>\r\n\r\n<p>世界第一批公共博物館設立於歐洲，在十七至十八世紀和啟蒙時代</p>\r\n\r\n<p>然而，這些「公共」博物館，往往只讓中上階級得以進入。想要拿到門票可能很難。例如在倫敦，想要參觀大英博物館的遊客必須以書面提出申請。即使到1800年，有可能必須等上兩個星期才拿到門票。小型團體的遊客只能逗留兩個小時。在維多利亞時代，英國的博物館流行在週日下午開放（在這類設施中，唯一被允許這樣做的），以便讓其他階級--勞工階級，有機會「自我提升」。</p>\r\n\r\n<p>第一個真正的公共博物館是巴黎羅浮宮，在1793年法國大革命期間開設，這是歷史上首次讓各地與各種地位的人們，自由看到前法國王室的蒐藏。幾個世紀以來，由法國君主蒐藏的美妙藝術珍藏，每十天對公眾開放三天（在法國共和曆，十天的計時單位用來取代星期）。國家藝術保護博物館（<i>Conservatoire du mus&eacute;um national des Arts</i>）被賦予職責，將羅浮宮組織成一座國立公共博物館，以及國家博物館系統的核心。法國拿破崙一世征服了歐洲最偉大的城市，所到之處，沒收了當地藝術品，這個藏品量增加，而且組織任務變得越來越複雜。拿破崙戰敗後，1815年，許多的寶藏逐漸歸還原主（有許多並沒有）。他的計劃從未完全實現，他將博物館當成國家主義熱情的推動者，這個概念在歐洲各地產生了深遠影響。</p>\r\n\r\n<p>美國博物館最終加入歐洲博物館，在他們感興趣的領域，成為在世界居於領先地位的新知識生產中心。一段密集的博物館建設時期，同時就知性與物質的意義而言，在十九世紀末和二十世紀初實現了（這往往稱為「博物館時期」或「博物館時代」）<sup id=\"cite_ref-vanDijke_6-0\">[6]</sup>。雖然美國的許多博物館，自然史博物館和美術館同樣，都是意圖聚焦於北美地區的科學發現和藝術發展，許多博物館在某些方面仿效他們的歐洲同行（包括發展從埃及、希臘、美索不達米亞和羅馬的古典蒐藏)。在美國，在第二次世界大戰開始之前，大學就已成為主要的創新研究中心。然而，時至今日，博物館依然將新的知識貢獻給他們的園地，並持續建立對於研究和展示皆有助益的蒐藏。</p>\r\n\r\n<div class=\"embed-240p\" data-oembed-url=\"https://zh.wikipedia.org/wiki/%E5%8D%9A%E7%89%A9%E9%A6%86\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"padding-bottom: 67.0017%; padding-top: 120px;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E5%258D%259A%25E7%2589%25A9%25E9%25A6%2586&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E5%258D%259A%25E7%2589%25A9%25E9%25A6%2586\">博物馆</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "教育")

        when 18
          issue.title = "奈米黃金"
          issue.content = "<p><img alt=\"Green Grass Close Up Photo\" height=\"182\" src=\"https://images.pexels.com/photos/1125769/pexels-photo-1125769.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"323\" /></p>\r\n\r\n<p><b>奈米黃金</b>或<b>奈米金</b>（英語：nanogold），又稱<b>膠態金</b>（colloidal gold），因為它在空氣中容易聚集成為塊材黃金，所以一般都把奈米黃金製備在溶液系統中。膠態金水溶液呈現懸浮溶液的特色，溶液中金顆粒大小約在次微米尺寸（小於1微米）。在溶液中，尺寸大小低於100奈米的膠態金粒子常致使溶液帶有強烈的紅色，而尺寸大小高於100奈米的膠態金粒子則使溶液呈藍色或紫色。<sup id=\"cite_ref-ref1_2-0\">[2]</sup><sup id=\"cite_ref-ref3_3-0\">[3]</sup></p>\r\n\r\n<p>由於金奈米粒子特殊的光學性質、電子性質、分子識別性質與良好的生物相容性，使奈米黃金成為了最廣泛被研究的金屬奈米材料，目前已應用於各種不同領域，如電子顯微鏡學、電子學、材料科學、奈米科技<sup id=\"cite_ref-ref4_4-0\">[4]</sup><sup id=\"cite_ref-ref5_5-0\">[5]</sup>、生化感測、光學偵測、藥物投遞、催化反應、疾病治療、電子工程以及模板結晶等。</p>\r\n\r\n<p>奈米黃金的性質、應用深深地受到尺寸和形狀的影響。<sup id=\"cite_ref-6\">[6]</sup>舉例來說，棒狀的奈米黃金粒子在UV光譜圖上具有橫向吸收峰和縱向吸收峰，而且非等向性的形狀也影響了分子自組裝時的行為。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E5%A5%88%E7%B1%B3%E9%BB%83%E9%87%91\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E5%25A5%2588%25E7%25B1%25B3%25E9%25BB%2583%25E9%2587%2591&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E5%25A5%2588%25E7%25B1%25B3%25E9%25BB%2583%25E9%2587%2591\">奈米黃金</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "科學")
          topic_taged(issue, "化學")

        when 19
          issue.title = "分享就是一種學習"
          issue.content = "<section name=\"f067\">\r\n<figure id=\"97d9\" name=\"97d9\">\r\n<p><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/800/1*FsiN9x7UpByRq7voZnb7eg.jpeg\" src=\"https://cdn-images-1.medium.com/max/800/1*FsiN9x7UpByRq7voZnb7eg.jpeg\" /></p>\r\n</figure>\r\n\r\n<p id=\"1223\" name=\"1223\">分享是自我學習的最佳方法之一，而分享的方式可以透過演講、教導、寫部落格、或是單純與人交流，這是快速且有效的。</p>\r\n\r\n<p id=\"0b6e\" name=\"0b6e\">這是因為分享之前，你會先去搜集資料、吸收相關知識、歸納整理，最終統整出自己的見解，然後分享出去。在這個過程，你的大腦會重整這些資訊，幫助你更透徹理解這些知識，通常當你有辦法分享，代表你真正理解這些知識。</p>\r\n\r\n<h3 id=\"ab7a\" name=\"ab7a\">演講練習</h3>\r\n\r\n<figure id=\"610c\" name=\"610c\">\r\n<p><canvas height=\"37\" width=\"75\"></canvas><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/800/1*L1wpZZWuHmP5S45Mz0-x5A.jpeg\" src=\"https://cdn-images-1.medium.com/max/800/1*L1wpZZWuHmP5S45Mz0-x5A.jpeg\" /></p>\r\n</figure>\r\n\r\n<p id=\"5a6c\" name=\"5a6c\">在美國加州一間叫做Ad Astra的學校，由Elon Musk創辦，那是為7~14歲孩子所創辦的學校，在那裡，每年會有一次的大考驗，他們要求孩子在幾百個成年人面前演講，2016年他們去了加州大學洛杉磯分校，2017年則是去南加州大學。而成年人將對他們的演講做出評價，這些評價都是真實反饋，而非虛浮的「你好棒」或是「你真優秀」，是實際針對孩子的演講風格、主題內容、說服力、感染力等做實質的建議。每次的演講都會讓孩子精進不少，除了對知識的認知外，他們也從中學習如何整理出自己的洞見、如何傳達自己的想法、並了解這個社會的反饋。</p>\r\n\r\n<p id=\"0f21\" name=\"0f21\">（可參閱另一篇文章：<a data-href=\"https://medium.com/@ari_chen/ad-astra-通往星星的教育-97698b1f5aab\" href=\"https://medium.com/@ari_chen/ad-astra-%E9%80%9A%E5%BE%80%E6%98%9F%E6%98%9F%E7%9A%84%E6%95%99%E8%82%B2-97698b1f5aab\" target=\"_blank\">Ad Astra，通往星星的教育</a>）</p>\r\n\r\n<h3 id=\"e8e7\" name=\"e8e7\">教導</h3>\r\n\r\n<p id=\"bec2\" name=\"bec2\">一定要成為老師才能教導其他人嗎？未必，就算你不是老師，就算你沒有修教育學程，那又如何？你還是可以分享你的知識，你還是可以指導他人，因為有很多經驗與洞見不是書本、學校學來，而是從你的生命中萃取而來，這是獨一無二的。</p>\r\n\r\n<p id=\"d797\" name=\"d797\">或許你會害怕自己只是初學，自己還沒有足夠的能力，怕自己講錯，但其實這些都是多慮，重點在於你統整這些知識的過程，讓你能夠更深入這個領域，其實在你準備如何指導別人時，你就已經進行一次深度的學習之旅了。</p>\r\n\r\n<h3 id=\"20b5\" name=\"20b5\">寫部落格</h3>\r\n\r\n<figure id=\"8fdd\" name=\"8fdd\">\r\n<p><canvas height=\"47\" width=\"75\"></canvas><img alt=\"\" data-src=\"https://cdn-images-1.medium.com/max/800/1*mLlxUuIiOBw9pOKa-E5usA.jpeg\" src=\"https://cdn-images-1.medium.com/max/800/1*mLlxUuIiOBw9pOKa-E5usA.jpeg\" /></p>\r\n</figure>\r\n\r\n<p id=\"3c8d\" name=\"3c8d\">文章是思想的反映，你的思維、觀念、見解、邏輯都會反射在你的字裡行間中，每次寫文章，其實就是一種思考的過程，這是活化大腦的方式，將強化大腦神經元之間的連結。</p>\r\n\r\n<p id=\"9a5a\" name=\"9a5a\">你可以把自己的專業知識、產業洞見、經驗、思維透過文章的形式與他人交流，然後在獲得別人反饋之後又進一步學習成長。</p>\r\n\r\n<p id=\"7b77\" name=\"7b77\">或許你覺得自己的文筆不好，但是重點應該在於你文章的邏輯結構，而不是優美的用字遣詞，因為這並不是什麼作文比賽，你只要把自己的思維知識清楚的表達出來即可。</p>\r\n\r\n<p id=\"fff9\" name=\"fff9\">你可能也會擔心自己的文章是班門弄斧，或是覺得別人早就知道你所寫的知識內容了，然而事實上，你點出的問題或文章內容，可能剛好也是別人遇到的問題，你寫文章幫助自己重新統整這些知識，也幫助了別人解決他們所遇到的問題。</p>\r\n\r\n<p id=\"1fc5\" name=\"1fc5\">我知道你會擔心寫了文章卻都沒有人看，其實一開始這是正常的，一般來說，寫文章必須長期累積，天天寫，至少也要3～12個月才會慢慢有效果，所以這需要足夠的毅力，很多人因為一開始沒人看就放棄了，而且根本寫不到一兩個月，文章可能也是零星幾篇，這都很可惜。</p>\r\n\r\n<p id=\"db45\" name=\"db45\">我是這麼告訴自己的：就算我的文章沒什麼人看，但是在過程中，或許只要有一些人，即便僅僅只是一個人，能夠因為我的文章而受到一些啟發，能夠正向的學習與思考，能夠讓人生開始有這麼一點點不一樣，那麼，我的一小步，就是重要的一步。</p>\r\n\r\n<h3 id=\"446a\" name=\"446a\">知識交流</h3>\r\n\r\n<p id=\"19fd\" name=\"19fd\">有些人可能會有一些好點子，或是非常有建設性的見解，但是卻害怕分享給他人，因為擔心別人會抄襲。你要想，全世界74億人，你的點子可能早就被想過好幾次了，況且在這資訊取得容易的時代，知識早就沒有秘密，但是透過你的分享，可以幫助他人整理這些知識，慢慢地別人會認為你是這個產業的專家，以後當他們遇到問題，第一個就是想到你。</p>\r\n\r\n<p id=\"eb63\" name=\"eb63\">不要把知識藏起來，就算你不說，別人也會找其他管道學習，知識不應該是秘密，它需要交流才能夠活化，當自己在跟別人交流知識時，你會獲得他人的反饋與意見，這時很有可能會有突破一些盲點的機會，同時這也是一種自我成長的過程。</p>\r\n</section>\r\n\r\n<section name=\"5970\">\r\n<hr />\r\n<p id=\"b787\" name=\"b787\">如果你有自己的想法、知識、洞見，請不要害怕，這可能會讓你錯失許多成長機會，更不要藏私，這只會降低你的眼界格局。請大方分享出來，讓你的知識更具價值與意義，這是自我價值的提升，也是人生的成長！</p>\r\n</section>\r\n\r\n<section name=\"dfb2\">\r\n<hr />\r\n<blockquote id=\"8119\" name=\"8119\">如果你對我的文章有興趣，想要了解更多，以及關於LunaX與LunaLab，歡迎寫信給我（caelus315@gmail.com），我將一一回覆。</blockquote>\r\n\r\n<blockquote id=\"4a13\" name=\"4a13\">【關於LunaX】有鑒於學習的本質：解決問題與提升狀態，我們發展兩個教育品牌：LunaX與 LunaLab，LunaX為線上學習平台，LunaLab為專為孩子設計的課程實驗室，都是為了幫助人們學習，並提升解決問題的能力。</blockquote>\r\n\r\n<blockquote id=\"c082\" name=\"c082\">FB&nbsp;:&nbsp;<a data-href=\"https://www.facebook.com/lunax.lunalab/\" href=\"https://www.facebook.com/lunax.lunalab/\" rel=\"nofollow noopener nofollow noopener\" target=\"_blank\">https://www.facebook.com/lunax.lunalab/</a></blockquote>\r\n</section>\r\n"
          topic_taged(issue, "成長思維")
          topic_taged(issue, "教育")
          topic_taged(issue, "生活")

        when 20
          issue.title = "淺談專利"
          issue.content = "<p><img alt=\"Gray Car Die-cast Model\" height=\"217\" src=\"https://images.pexels.com/photos/1249650/pexels-photo-1249650.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"389\" /></p>\r\n\r\n<p><b>專利</b>，即專利權的簡稱，主要分為發明、實用新型及工業設計三種類型。各國政府設立專利制度，其目的在於鼓勵民眾從事發明，保護發明人（或其受讓人或繼承人）的權利，並指導專利權人與民眾以合法、適當的方式利用發明，以促進產業發展。專利制度是讓專利權人在法定期間（例如：20年）內享有專利技術的排他權（注意，並非獨占權），使其享有商業上的特權利益，以鼓勵其將知識公開分享。當專利權法定期間屆滿，專利權即告消滅，民眾即可根據專利說明書所揭露的內容，自由運用其專利技術。</p>\r\n\r\n<p>申請專利，必須向政府機關提出「專利說明書」，明確且充分揭露其發明技術的內容到可具體實施的地步（不可僅是漫天空想），並界定請求的權利範圍。請求的權利範圍如不符合專利要件（例如：發明是既有的習知技術），就會被駁回，無法取得專利權。由於專利要件的判斷涉及不確定法律概念，專利專責機關對專利範圍在其判斷餘地中所為的專業判斷經常引發爭議，因而導致專利爭訟。</p>\r\n\r\n<div data-oembed-url=\"https://zh.wikipedia.org/wiki/%E4%B8%93%E5%88%A9\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"height: 168px; padding-bottom: 0;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E4%25B8%2593%25E5%2588%25A9&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E4%25B8%2593%25E5%2588%25A9\">专利</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "商業")
          topic_taged(issue, "專利") 

        when 21
          issue.title = "運動333/運動357"
          issue.content = "<p>&nbsp;<img alt=\"adventure, athlete, athletic\" height=\"270\" src=\"https://images.pexels.com/photos/235922/pexels-photo-235922.jpeg?auto=compress&amp;cs=tinysrgb&amp;h=650&amp;w=940\" width=\"406\" /></p>\r\n\r\n<p>進行體育運動時，當心率達到最大心率的50%－90%，就可認定是在進行有氧訓練，或者可以用自我感覺對自己運動時的狀態測定，在自我感覺「很輕鬆」、「比較輕鬆」、「有點累」、「比較累」、「很累」五個等級中，如果認為是「有點累」，到「比較累」之間，也可認定是有氧運動。要達到增強耐力的鍛鍊效果，有氧訓練的最低要求是，每天累計鍛鍊時間30分鐘，每周運動三次。</p>\r\n\r\n<p>比較科學的定義，有氧運動是指長時間（15分鐘以上）、有節奏、會令心跳率上升的大肌肉運動。</p>\r\n\r\n<h3>運動333</h3>\r\n\r\n<p>每周運動3次，每次超過30分鐘，心跳每分鐘130下。<sup id=\"cite_ref-2\">[2]</sup></p>\r\n\r\n<h3>運動357</h3>\r\n\r\n<p>運動每次應達30分鐘，每周5次，運動時每分鐘心跳數應達最大心跳數的7成。<sup id=\"cite_ref-3\">[3]</sup></p>\r\n\r\n<p><b>預估最大心跳數</b>的公式為220減去自己的年齡。例如一位24歲且「<u>沒有心血管疾病</u>」的大學生的預估最大心跳數為：220-24=196 (心跳/每分鐘).</p>\r\n\r\n<h3>測定之替代方案</h3>\r\n\r\n<p>評估運動時喘的程度，應達到感覺有點喘，但還可以講話，便是適當的運動強度，但若喘到沒辦法講話，代表超出心臟可負荷範圍。</p>\r\n\r\n<h3>運動須知</h3>\r\n\r\n<ul>\r\n\t<li>運動不分季節，但要量力而為。</li>\r\n\t<li>高血壓不宜劇烈運動。台大醫院復健科醫師 陳思遠：「運動357的準則是強調運動的時間、頻率和強度，但如果高血壓患者從事過於劇烈的運動，例如激烈的羽球、籃球競賽等，容易在短時間內就喘不過氣，甚至血壓飆高，危及健康。」</li>\r\n\t<li>中老年人要達到333原則有點吃力，建議以運動完會喘，但仍可說話為原則，避免運動到上氣不接下氣。</li>\r\n\t<li>年輕人則應以運動333原則為低標，選擇跑步、騎單車或游泳等有氧運動，每周3次運動各至少30分鐘，促進新陳代謝，可改善身體機能。</li>\r\n</ul>\r\n\r\n<div class=\"embed-240p\" data-oembed-url=\"https://zh.wikipedia.org/wiki/%E6%9C%89%E6%B0%A7%E8%BF%90%E5%8A%A8\">\r\n<div class=\"iframely-embed\">\r\n<div class=\"iframely-responsive\" style=\"padding-bottom: 52.2493%; padding-top: 120px;\"><a data-iframely-url=\"//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%25E6%259C%2589%25E6%25B0%25A7%25E8%25BF%2590%25E5%258A%25A8&amp;key=362e0e28db58eb85d2d0307a53f31d0e\" href=\"https://zh.wikipedia.org/wiki/%25E6%259C%2589%25E6%25B0%25A7%25E8%25BF%2590%25E5%258A%25A8\">有氧运动</a></div>\r\n</div>\r\n<script async=\"\" charset=\"utf-8\" src=\"//cdn.iframe.ly/embed.js\"></script>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n"
          topic_taged(issue, "運動")
          topic_taged(issue, "有氧運動")

      end

      issue.save!
      puts "第 #{now} 筆issue產生"
      now = now + 1
    end
  end

  # 產生收藏
  task demo_bookmarks: :environment do
    Bookmark.destroy_all
      User.all.each do |user|
      count = 0
      1..Issue.count.times do |j|
        issue = Issue.all.sample
        if issue.is_bookmarked?(user)
          count = count
        else
          user.bookmarks.create(issue: issue)
          count = count + 1
        end
      end
    end
    puts "now you have #{Bookmark.count} bookmarks data (#{Bookmark.first.id}..#{Bookmark.last.id})"
  end

  # 產生like
  task demo_likes: :environment do
    Like.destroy_all
      User.all.each do |user|
      count = 0
      1..Issue.count.times do |j|
        issue = Issue.all.sample
        if issue.is_liked?(user)
          count = count
        else
          user.likes.create(issue: issue)
          count = count + 1
        end
      end
    end
    puts "now you have #{Like.count} likes data (#{Like.first.id}..#{Like.last.id})"
  end

  # 產生comment
  task demo_comments: :environment do
    Comment.destroy_all
    User.all.each do |user|
      count = 0
      COMMENT_NUM.times do |j|
        issue = Issue.all.sample 
        case rand(1..5)
          when 1
            comment_content = "謝謝分享，長知識了。"
          when 2
            comment_content = "感謝大大無私分享！"
          when 3
            comment_content = "原來還有這種解釋！"
          when 4
            comment_content = "這篇真的很有水準，精彩見解。"
          when 5
            comment_content = "我開始相信你了"
        end      
        user.comments.create(
          issue: issue,
          content: comment_content
        )
        count = count + 1
      end
    end
    puts "now you have #{Comment.count} comments data (#{Comment.first.id}..#{Comment.last.id})"
  end

  # 產生reply
  task demo_replies: :environment do
    Reply.destroy_all
    User.all.each do |user|
      count = 0
      REPLY_NUM.times do |j|
        comment = Comment.all.sample
        case rand(1..5)
          when 1
            reply_content = "我也這麼覺得"
          when 2
            reply_content = "認同"
          when 3
            reply_content = "原來不是只有我不知道"
          when 4
            reply_content = "這篇文真的不錯"
          when 5
            reply_content = "恩恩"
        end 
        user.replies.create(
          comment: comment,
          content: reply_content
        )
        count = count + 1
      end
    end
    puts "now you have #{Reply.count} replies data (#{Reply.first.id}..#{Reply.last.id})"
  end

  task issue_all: :environment do
    # 建立 Demo 用 Issue 資料和Issue Tag Topic
    puts "demo_issue processing..."
    Rake::Task['issue:demo_issue'].execute

    # 待 demo Issue 建立後，更新下列 task 內容
    # Relationship between User and Issue
    puts "demo_bookmarks processing..."
    Rake::Task['issue:demo_bookmarks'].execute
    puts "demo_comments processing..."
    Rake::Task['issue:demo_comments'].execute
    puts "demo_likes processing..."
    Rake::Task['issue:demo_likes'].execute
    puts "demo_replies processing..."
    Rake::Task['issue:demo_replies'].execute
  end

  # issue_taged_topic
  def topic_taged(issue, topic_name)
    issue.topic_tagships.create(
      topic: Topic.find_by_name(topic_name)
      )
  end
end
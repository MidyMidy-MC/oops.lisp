(in-package :midymidybot)

(defun make-death-message-regex (regex-list)
  (with-output-to-string (s)
    (format s "^.* (")
    (do ((lst regex-list (cdr lst)))
        ((null lst))
      (if (cdr lst)
          (format s "~A|" (car lst))
          (format s "~A)$" (car lst))))))

(defparameter *minecraft-death-message-list*
  (make-death-message-regex
   '("was shot by.*"
     "was pricked to death"
     "hugged a cactus"
     "walked into a cactus while trying to escape.*"
     "was stabbed to death"
     "drowned"
     "drowned whilst trying to escape"
     "experienced kinetic energy"
     "removed an elytra while flying"
     "blew up"
     "was blown up by.*"
     "was killed by.*"
     "hit the ground too hard"
     "fell from a high place"
     "fell off a ladder"
     "fell off some vines"
     "fell out of the water"
     "fell into a patch of fire"
     "fell into a patch of cacti"
     "was doomed to fall by.*"
     "was shot off some vines by.*"
     "was shot off a ladder by.*"
     "was blown from a high place by.*"
     "was squashed by a falling anvil"
     "was squashed by a falling block"
     "went up in flames"
     "burned to death"
     "was burnt to a crisp whilst fighting.*"
     "walked into a fire whilst fighting.*"
     "went off with a bang"
     "tried to swim in lava"
     "tried to swim in lava while trying to escape"
     "was struck by lightning"
     "discovered floor was lava"
     "was slain by.*"
     "got finished off by.*"
     "was fireballed by.*"
     "was killed by magic"
     "was killed by.*"
     "starved to death"
     "suffocated in a wall"
     "was squished too much"
     "was killed while trying to hurt.*"
     "fell out of the world"
     "fell from a high place and fell out of the world"
     "withered away"
     "was pummeled by.*"
     "died")))

;; (ql:quickload 'cl-ppcre)
;; (defparameter *test-func*
;;   (eval `(lambda (str)
;;            (cl-ppcre:all-matches ,*minecraft-death-message-list* str))))
;; (time
;;  (dotimes (i 10000)
;;    (funcall *test-func* "leo_song fell from a high place and fell out of the world")))
;; (defun test-func (regex str)
;;   (cl-ppcre:all-matches regex str))
;; (time
;;  (dotimes (i 10000)
;;    (test-func *minecraft-death-message-list* "leo_song fell from a high place and fell out of the world")))

(defparameter *sarcasm*
  #("真弱鸡啊……"
    "行不行啊？"
    "不得行啊……"
    "安全生产 重于泰山"
    "-1s"
    "星际玩家？"
    "哈哈哈红红火火何厚铧喊憨厚韩寒嘿嘿嘿"
    "[减500绿宝石]（"
    "看来你还不知道生命的可贵"
    "小黑在看着你"
    "[清空经验和道具栏]（"
    "我就看着你作死"
    "僵尸在看着你"
    "小白在看着你"
    "[达到死亡次数限制，从白名单移除]（"
    "你的寿命在以可见的速度流逝"
    "最怕空气突然安静"
    "送上一曲《凉凉》"
    "伙计倒下了！伙计倒下了！"
    "当一艘船沉入海底，当一个人成了谜~"
    "快别作死了行不行，保险公司都赔破产了"
    "嘿！这里死了不会变成盒子"
    "玩家 OUT，玩家 OUT"
    "啊朋友再见，啊朋友再见，啊朋友再见吧再见吧再见吧~"
    "Death, or new born"
    "[玩家数据删除]（"
    "朋友，收尸很麻烦的……"
    "亲，你还有复活币吗？"
    "小道新闻：阎王拒绝了玩家的加群请求"
    "胜败乃兵家常事 大侠请重新来过吧"
    "Is there a doctor in the server?"
    "桥豆麻袋，刚才发生了什么事情吗？（黑人问号"
    "死神：这是在割韭菜吗？"))

(defun get-oops-msg (msg)
  (declare (ignore msg))
  (concatenate 'string
               "oops... "
               (aref *sarcasm* (random (length *sarcasm*)))))

(defun act-on-death-message (msg)
  (declare (ignore msg))
  (handler-case
      (let ((oops-msg (get-oops-msg nil)))
        (send-irc-message *bot1* oops-msg)
        (send-tg-message *bot1* oops-msg))
    (condition (e)
      (logging
       (bot-name *bot1*) "hook ERROR:~S!" e))))

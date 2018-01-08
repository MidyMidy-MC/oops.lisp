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

(defun act-on-death-message (msg)
  (declare (ignore msg))
  (handler-case
      (progn
        (send-irc-message *bot1* "oops...")
        (send-tg-message *bot1* "oops..."))
    (condition (e)
      (logging
       (bot-name *bot1*) "hook ERROR:~S!" e))))
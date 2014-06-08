;;; websocket_trigger.el --- WebSocketサーバに対してメッセージを送るスクリプト

;; Copyright (C) 2014 Kouki Higashikawa

;; Author: Kouki Higashikawa, 2014
;; Keywords: websocket
;; Created: 2014-06-01
;; Modigied: 2014-06-01

(require 'websocket)
(eval-when-compile (require 'cl))

(defvar ws-msgs nil)
(defvar ws-closed nil)
(defvar ws-client nil)

(defun ws-server-start ()
  "WebSocket server start..."
  (interactive)
  (defvar ws-server-buffer (get-buffer-create "*ws-server*"))
  (defvar ws-server-name "ws-server")
  (defvar ws-server-proc
    (start-process ws-server-name ws-server-buffer
		   "ruby" "websocket_server.rb")))

(defun ws-server-close ()
  "WebSocket server close..."
  (interactive)
  (stop-process ws-server-proc))

(defun ws-client-connection ()
  "WebSocket connection..."
  (interactive)
  (setq ws-client
	(websocket-open
	 "ws://127.0.0.1:8125"
	 (lambda (p) (push p ws-msgs) (message "ws packet: %S" p))
	 (lambda () (setq ws-closed t))))
  (sleep-for 0.1)
  (websocket-openp ws-client))

(defun ws-client-close ()
  "WebSocket close."
  (interactive)
  (websocket-close ws-client))

(defun ws-client-send-message ()
  "WebSocket send broadcast message."
  (interactive)
  (websocket-send ws-client "doReload!"))

;;; Key setting.
(define-key yas-minor-mode-map (kbd "C-c w s") 'ws-server-start)
(define-key yas-minor-mode-map (kbd "C-c w s c") 'ws-server-close)
(define-key yas-minor-mode-map (kbd "C-c w c") 'ws-client-connection)
(define-key yas-minor-mode-map (kbd "C-c w c c") 'ws-client-close)
(define-key yas-minor-mode-map (kbd "C-q") 'ws-client-send-message)

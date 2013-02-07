;;=================
;; node.jsサーバとTCP通信するためのスクリプトと、関数をキーバインドするスクリプトファイル
;; Date: 2013/02/06 ~ 
;;=================

;; script
(defun node-script-insert () (interactive) (insert "<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'></script><script src='http://localhost:8124/socket.io/socket.io.js'></script><script>$(function(){ var socket = new io.connect('http://localhost:8124'); socket.on('message', function(message){ $('body').append(message);}); }); </script>"))

;; tpc connection
(defun tcp-connection ()
  (interactive)
  (setq proc (open-network-stream "http-proc" "*nodejs-tcp-buffer*" "localhost" 8125))
  (set-process-coding-system proc 'binary 'binary)
  (process-send-string proc "tcp-send"))

;; (data)-> tcp server
(defun tcp-send-data ()
  (interactive)
  (process-send-string proc "tcp-send"))

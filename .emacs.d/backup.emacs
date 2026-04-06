
(with-eval-after-load 'helm
  (evil-define-key 'emacs helm-find-files-map
    (kbd "M-j") #'helm-next-line
    (kbd "M-k") #'helm-previous-line
    (kbd "M-l") #'helm-execute-persistent-action
    (kbd "M-h") #'helm-find-files-up-one-level))

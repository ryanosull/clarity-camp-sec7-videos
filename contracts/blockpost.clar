
;; title: blockpost
;; version:
;; summary:
;; description: contract that writes a post on chain for a small fee

;; traits
;;

;; token definitions
;;

;; constants
;;
(define-constant contract-owner tx-sender) ;;tx-sender == contrat deployer

(define-constant price u1000000) ;; = 1 STX

;; data vars
;;

(define-data-var total-posts uint u0)

;; data maps
;;
(define-map posts principal (string-utf8 500)) ;; key = principal('STxxxxx): value = string



;; public functions
;;


(define-public (write-post (message (string-utf8 500)))
    (begin 
        (try! (stx-transfer? price tx-sender contract-owner))
        ;; #[allow(unchecked_data)]
        (map-set posts tx-sender message)
        (var-set total-posts (+ (var-get total-posts) u1))
        (ok "SUCCESS")
    )
)


;; read only functions
;;
(define-read-only (get-total-posts) 
    (var-get total-posts) ;;get the var total-posts
)

(define-read-only (get-posts (user principal)) ;;grab posts for a specific principal;; takes in param user, type principal
    (map-get? posts user) ;; grab value of map, takes in name and key (define above, principal type);;will return string from user
)

;; private functions
;;


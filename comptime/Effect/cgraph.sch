;; ==========================================================
;; Class accessors
;; Bigloo (4.6a)
;; Inria -- Sophia Antipolis     Thu Aug 29 03:10:46 PM CEST 2024 
;; (bigloo -classgen Effect/cgraph.scm)
;; ==========================================================

;; The directives
(directives

;; local/from
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-local/from::local/from id1172::symbol name1173::obj type1174::type value1175::value access1176::obj fast-alpha1177::obj removable1178::obj occurrence1179::long occurrencew1180::long user?1181::bool key1182::long val-noescape1183::obj volatile1184::bool from1185::obj)
    (inline local/from?::bool ::obj)
    (local/from-nil::local/from)
    (inline local/from-from::obj ::local/from)
    (inline local/from-from-set! ::local/from ::obj)
    (inline local/from-volatile::bool ::local/from)
    (inline local/from-volatile-set! ::local/from ::bool)
    (inline local/from-val-noescape::obj ::local/from)
    (inline local/from-val-noescape-set! ::local/from ::obj)
    (inline local/from-key::long ::local/from)
    (inline local/from-user?::bool ::local/from)
    (inline local/from-user?-set! ::local/from ::bool)
    (inline local/from-occurrencew::long ::local/from)
    (inline local/from-occurrencew-set! ::local/from ::long)
    (inline local/from-occurrence::long ::local/from)
    (inline local/from-occurrence-set! ::local/from ::long)
    (inline local/from-removable::obj ::local/from)
    (inline local/from-removable-set! ::local/from ::obj)
    (inline local/from-fast-alpha::obj ::local/from)
    (inline local/from-fast-alpha-set! ::local/from ::obj)
    (inline local/from-access::obj ::local/from)
    (inline local/from-access-set! ::local/from ::obj)
    (inline local/from-value::value ::local/from)
    (inline local/from-value-set! ::local/from ::value)
    (inline local/from-type::type ::local/from)
    (inline local/from-type-set! ::local/from ::type)
    (inline local/from-name::obj ::local/from)
    (inline local/from-name-set! ::local/from ::obj)
    (inline local/from-id::symbol ::local/from))))

;; global/from
(cond-expand ((and bigloo-class-sans (not bigloo-class-generate))
  (export
    (inline make-global/from::global/from id1150::symbol name1151::obj type1152::type value1153::value access1154::obj fast-alpha1155::obj removable1156::obj occurrence1157::long occurrencew1158::long user?1159::bool module1160::symbol import1161::obj evaluable?1162::bool eval?1163::bool library1164::obj pragma1165::obj src1166::obj qualified-type-name1167::bstring init1168::obj alias1169::obj from1170::obj)
    (inline global/from?::bool ::obj)
    (global/from-nil::global/from)
    (inline global/from-from::obj ::global/from)
    (inline global/from-from-set! ::global/from ::obj)
    (inline global/from-alias::obj ::global/from)
    (inline global/from-alias-set! ::global/from ::obj)
    (inline global/from-init::obj ::global/from)
    (inline global/from-init-set! ::global/from ::obj)
    (inline global/from-qualified-type-name::bstring ::global/from)
    (inline global/from-qualified-type-name-set! ::global/from ::bstring)
    (inline global/from-src::obj ::global/from)
    (inline global/from-src-set! ::global/from ::obj)
    (inline global/from-pragma::obj ::global/from)
    (inline global/from-pragma-set! ::global/from ::obj)
    (inline global/from-library::obj ::global/from)
    (inline global/from-library-set! ::global/from ::obj)
    (inline global/from-eval?::bool ::global/from)
    (inline global/from-eval?-set! ::global/from ::bool)
    (inline global/from-evaluable?::bool ::global/from)
    (inline global/from-evaluable?-set! ::global/from ::bool)
    (inline global/from-import::obj ::global/from)
    (inline global/from-import-set! ::global/from ::obj)
    (inline global/from-module::symbol ::global/from)
    (inline global/from-module-set! ::global/from ::symbol)
    (inline global/from-user?::bool ::global/from)
    (inline global/from-user?-set! ::global/from ::bool)
    (inline global/from-occurrencew::long ::global/from)
    (inline global/from-occurrencew-set! ::global/from ::long)
    (inline global/from-occurrence::long ::global/from)
    (inline global/from-occurrence-set! ::global/from ::long)
    (inline global/from-removable::obj ::global/from)
    (inline global/from-removable-set! ::global/from ::obj)
    (inline global/from-fast-alpha::obj ::global/from)
    (inline global/from-fast-alpha-set! ::global/from ::obj)
    (inline global/from-access::obj ::global/from)
    (inline global/from-access-set! ::global/from ::obj)
    (inline global/from-value::value ::global/from)
    (inline global/from-value-set! ::global/from ::value)
    (inline global/from-type::type ::global/from)
    (inline global/from-type-set! ::global/from ::type)
    (inline global/from-name::obj ::global/from)
    (inline global/from-name-set! ::global/from ::obj)
    (inline global/from-id::symbol ::global/from)))))

;; The definitions
(cond-expand (bigloo-class-sans
;; local/from
(define-inline (make-local/from::local/from id1172::symbol name1173::obj type1174::type value1175::value access1176::obj fast-alpha1177::obj removable1178::obj occurrence1179::long occurrencew1180::long user?1181::bool key1182::long val-noescape1183::obj volatile1184::bool from1185::obj) (instantiate::local/from (id id1172) (name name1173) (type type1174) (value value1175) (access access1176) (fast-alpha fast-alpha1177) (removable removable1178) (occurrence occurrence1179) (occurrencew occurrencew1180) (user? user?1181) (key key1182) (val-noescape val-noescape1183) (volatile volatile1184) (from from1185)))
(define-inline (local/from?::bool obj::obj) ((@ isa? __object) obj (@ local/from effect_cgraph)))
(define (local/from-nil::local/from) (class-nil (@ local/from effect_cgraph)))
(define-inline (local/from-from::obj o::local/from) (-> |#!bigloo_wallow| o from))
(define-inline (local/from-from-set! o::local/from v::obj) (set! (-> |#!bigloo_wallow| o from) v))
(define-inline (local/from-volatile::bool o::local/from) (-> |#!bigloo_wallow| o volatile))
(define-inline (local/from-volatile-set! o::local/from v::bool) (set! (-> |#!bigloo_wallow| o volatile) v))
(define-inline (local/from-val-noescape::obj o::local/from) (-> |#!bigloo_wallow| o val-noescape))
(define-inline (local/from-val-noescape-set! o::local/from v::obj) (set! (-> |#!bigloo_wallow| o val-noescape) v))
(define-inline (local/from-key::long o::local/from) (-> |#!bigloo_wallow| o key))
(define-inline (local/from-key-set! o::local/from v::long) (set! (-> |#!bigloo_wallow| o key) v))
(define-inline (local/from-user?::bool o::local/from) (-> |#!bigloo_wallow| o user?))
(define-inline (local/from-user?-set! o::local/from v::bool) (set! (-> |#!bigloo_wallow| o user?) v))
(define-inline (local/from-occurrencew::long o::local/from) (-> |#!bigloo_wallow| o occurrencew))
(define-inline (local/from-occurrencew-set! o::local/from v::long) (set! (-> |#!bigloo_wallow| o occurrencew) v))
(define-inline (local/from-occurrence::long o::local/from) (-> |#!bigloo_wallow| o occurrence))
(define-inline (local/from-occurrence-set! o::local/from v::long) (set! (-> |#!bigloo_wallow| o occurrence) v))
(define-inline (local/from-removable::obj o::local/from) (-> |#!bigloo_wallow| o removable))
(define-inline (local/from-removable-set! o::local/from v::obj) (set! (-> |#!bigloo_wallow| o removable) v))
(define-inline (local/from-fast-alpha::obj o::local/from) (-> |#!bigloo_wallow| o fast-alpha))
(define-inline (local/from-fast-alpha-set! o::local/from v::obj) (set! (-> |#!bigloo_wallow| o fast-alpha) v))
(define-inline (local/from-access::obj o::local/from) (-> |#!bigloo_wallow| o access))
(define-inline (local/from-access-set! o::local/from v::obj) (set! (-> |#!bigloo_wallow| o access) v))
(define-inline (local/from-value::value o::local/from) (-> |#!bigloo_wallow| o value))
(define-inline (local/from-value-set! o::local/from v::value) (set! (-> |#!bigloo_wallow| o value) v))
(define-inline (local/from-type::type o::local/from) (-> |#!bigloo_wallow| o type))
(define-inline (local/from-type-set! o::local/from v::type) (set! (-> |#!bigloo_wallow| o type) v))
(define-inline (local/from-name::obj o::local/from) (-> |#!bigloo_wallow| o name))
(define-inline (local/from-name-set! o::local/from v::obj) (set! (-> |#!bigloo_wallow| o name) v))
(define-inline (local/from-id::symbol o::local/from) (-> |#!bigloo_wallow| o id))
(define-inline (local/from-id-set! o::local/from v::symbol) (set! (-> |#!bigloo_wallow| o id) v))

;; global/from
(define-inline (make-global/from::global/from id1150::symbol name1151::obj type1152::type value1153::value access1154::obj fast-alpha1155::obj removable1156::obj occurrence1157::long occurrencew1158::long user?1159::bool module1160::symbol import1161::obj evaluable?1162::bool eval?1163::bool library1164::obj pragma1165::obj src1166::obj qualified-type-name1167::bstring init1168::obj alias1169::obj from1170::obj) (instantiate::global/from (id id1150) (name name1151) (type type1152) (value value1153) (access access1154) (fast-alpha fast-alpha1155) (removable removable1156) (occurrence occurrence1157) (occurrencew occurrencew1158) (user? user?1159) (module module1160) (import import1161) (evaluable? evaluable?1162) (eval? eval?1163) (library library1164) (pragma pragma1165) (src src1166) (qualified-type-name qualified-type-name1167) (init init1168) (alias alias1169) (from from1170)))
(define-inline (global/from?::bool obj::obj) ((@ isa? __object) obj (@ global/from effect_cgraph)))
(define (global/from-nil::global/from) (class-nil (@ global/from effect_cgraph)))
(define-inline (global/from-from::obj o::global/from) (-> |#!bigloo_wallow| o from))
(define-inline (global/from-from-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o from) v))
(define-inline (global/from-alias::obj o::global/from) (-> |#!bigloo_wallow| o alias))
(define-inline (global/from-alias-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o alias) v))
(define-inline (global/from-init::obj o::global/from) (-> |#!bigloo_wallow| o init))
(define-inline (global/from-init-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o init) v))
(define-inline (global/from-qualified-type-name::bstring o::global/from) (-> |#!bigloo_wallow| o qualified-type-name))
(define-inline (global/from-qualified-type-name-set! o::global/from v::bstring) (set! (-> |#!bigloo_wallow| o qualified-type-name) v))
(define-inline (global/from-src::obj o::global/from) (-> |#!bigloo_wallow| o src))
(define-inline (global/from-src-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o src) v))
(define-inline (global/from-pragma::obj o::global/from) (-> |#!bigloo_wallow| o pragma))
(define-inline (global/from-pragma-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o pragma) v))
(define-inline (global/from-library::obj o::global/from) (-> |#!bigloo_wallow| o library))
(define-inline (global/from-library-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o library) v))
(define-inline (global/from-eval?::bool o::global/from) (-> |#!bigloo_wallow| o eval?))
(define-inline (global/from-eval?-set! o::global/from v::bool) (set! (-> |#!bigloo_wallow| o eval?) v))
(define-inline (global/from-evaluable?::bool o::global/from) (-> |#!bigloo_wallow| o evaluable?))
(define-inline (global/from-evaluable?-set! o::global/from v::bool) (set! (-> |#!bigloo_wallow| o evaluable?) v))
(define-inline (global/from-import::obj o::global/from) (-> |#!bigloo_wallow| o import))
(define-inline (global/from-import-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o import) v))
(define-inline (global/from-module::symbol o::global/from) (-> |#!bigloo_wallow| o module))
(define-inline (global/from-module-set! o::global/from v::symbol) (set! (-> |#!bigloo_wallow| o module) v))
(define-inline (global/from-user?::bool o::global/from) (-> |#!bigloo_wallow| o user?))
(define-inline (global/from-user?-set! o::global/from v::bool) (set! (-> |#!bigloo_wallow| o user?) v))
(define-inline (global/from-occurrencew::long o::global/from) (-> |#!bigloo_wallow| o occurrencew))
(define-inline (global/from-occurrencew-set! o::global/from v::long) (set! (-> |#!bigloo_wallow| o occurrencew) v))
(define-inline (global/from-occurrence::long o::global/from) (-> |#!bigloo_wallow| o occurrence))
(define-inline (global/from-occurrence-set! o::global/from v::long) (set! (-> |#!bigloo_wallow| o occurrence) v))
(define-inline (global/from-removable::obj o::global/from) (-> |#!bigloo_wallow| o removable))
(define-inline (global/from-removable-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o removable) v))
(define-inline (global/from-fast-alpha::obj o::global/from) (-> |#!bigloo_wallow| o fast-alpha))
(define-inline (global/from-fast-alpha-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o fast-alpha) v))
(define-inline (global/from-access::obj o::global/from) (-> |#!bigloo_wallow| o access))
(define-inline (global/from-access-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o access) v))
(define-inline (global/from-value::value o::global/from) (-> |#!bigloo_wallow| o value))
(define-inline (global/from-value-set! o::global/from v::value) (set! (-> |#!bigloo_wallow| o value) v))
(define-inline (global/from-type::type o::global/from) (-> |#!bigloo_wallow| o type))
(define-inline (global/from-type-set! o::global/from v::type) (set! (-> |#!bigloo_wallow| o type) v))
(define-inline (global/from-name::obj o::global/from) (-> |#!bigloo_wallow| o name))
(define-inline (global/from-name-set! o::global/from v::obj) (set! (-> |#!bigloo_wallow| o name) v))
(define-inline (global/from-id::symbol o::global/from) (-> |#!bigloo_wallow| o id))
(define-inline (global/from-id-set! o::global/from v::symbol) (set! (-> |#!bigloo_wallow| o id) v))
))

;*=====================================================================*/
;*    .../prgm/project/bigloo/bigloo/comptime/SawBbv/bbv-debug.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Fri Oct  6 09:30:19 2023                          */
;*    Last change :  Fri Oct  6 09:43:54 2023 (serrano)                */
;*    Copyright   :  2023 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    bbv debugging tools                                              */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module saw_bbv-debug
   
   (include "Tools/trace.sch"
	    "Tools/location.sch"
	    "SawMill/regset.sch"
	    "SawMill/bbset.sch")
   
   (import  engine_param
	    ast_var
	    ast_node
	    type_type
	    type_cache
	    type_typeof
	    tools_shape
	    tools_speek
	    backend_backend
	    type_cache
	    saw_lib
	    saw_defs
	    saw_regset
	    saw_regutils
	    saw_bbv-config
	    saw_bbv-types
	    saw_bbv-specialize
	    saw_bbv-cache
	    saw_bbv-range)

   (export  (dump-blocks ::global ::pair-nil ::pair-nil ::bstring)
	    (assert-block ::blockS ::obj)
	    (assert-blocks ::blockS ::obj)
	    (assert-context! b::block)))

;*---------------------------------------------------------------------*/
;*    assert-block ...                                                 */
;*    -------------------------------------------------------------    */
;*    A debug fonction that tests the consistency of the preds,        */
;*    succs, and branch instructions.                                  */
;*---------------------------------------------------------------------*/
(define (assert-block b::blockS stage)
   (with-access::blockS b (preds succs first label parent)
      ;; check that b in the preds.succs
      (let ((l (filter (lambda (p)
			  (with-access::blockS p (succs)
			     (not (memq b succs))))
		  preds)))
	 (when (pair? l)
	    (tprint (shape b))
	    (tprint "preds...")
	    (for-each (lambda (b) (tprint (shape b))) l)
	    (error stage 
	       (format "predecessors not pointing to ~a" label)
	       (map block-label l))))
      ;; check that b in the succs.preds
      (let ((l (filter (lambda (p)
			  (with-access::blockS p (preds)
			     (not (memq b preds))))
		  succs)))
	 (when (pair? l)
	    (tprint (shape b))
	    (tprint "succs...")
	    (for-each (lambda (b) (tprint (shape b))) l)
	    (error stage
	       (format "successors not pointing to ~a" label)
	       (map block-label l))))
      ;; check that the instructions are in the succs
      (let ((l '()))
	 (for-each (lambda (ins)
		      (cond
			 ((rtl_ins-ifeq? ins)
			  (set! l (cons ins l)))
			 ((rtl_ins-ifne? ins)
			  (with-access::rtl_ins ins (fun)
			     (with-access::rtl_ifne fun (then)
				(unless (memq then succs)
				   (set! l (cons ins l))))))
			 ((rtl_ins-go? ins)
			  (with-access::rtl_ins ins (fun)
			     (with-access::rtl_go fun (to)
				(unless (memq to succs)
				   (set! l (cons ins l))))))
			 ((rtl_ins-switch? ins)
			  (with-access::rtl_ins ins (fun)
			     (with-access::rtl_switch fun (labels)
				(for-each (lambda (lbl)
					     (unless (memq lbl succs)
						(set! l (cons ins l))))
				   labels))))))
	    first)
	 (when (pair? l)
	    (tprint "wrong block: " (shape b))
	    (tprint "parent block: " (shape parent))
	    (error stage
	       (format "instruction target not in succs of " label)
	       (map shape l))))))

;*---------------------------------------------------------------------*/
;*    dump-blocks ...                                                  */
;*---------------------------------------------------------------------*/
(define (dump-blocks global params blocks suffix)

   (define oname
      (if (string? *dest*)
	  *dest*
	  (if (and (pair? *src-files*) (string? (car *src-files*)))
	      (prefix (car *src-files*))
	      "./a.out")))
   
   (define filename
      (string-replace (format "~a-~a~a" oname (global-id global) suffix)
	 #\/ #\_))
   
   (define name (prefix filename))
      
   (define (dump-blocks port)
      (let* ((id (global-id global)))
	 (fprint port ";; -*- mode: bee -*-")
	 (fprint port ";; *** " id ":")
	 (fprint port ";; " (map shape params))
	 (fprintf port ";; bglcfg '~a' > '~a.dot' && dot '~a.dot' -Tpdf > ~a.pdf\n"
	    filename name name name)
	 (for-each (lambda (b)
		      (dump b port 0)
		      (newline port))
	    blocks)
	 id))
   
   (if oname
       (call-with-output-file filename dump-blocks)
       (dump-blocks (current-error-port))))

;*---------------------------------------------------------------------*/
;*    assert-blocks ...                                                */
;*    -------------------------------------------------------------    */
;*    Coalesce requires dangling blocks to be removed from             */
;*    parent.versions. This pass implements a simple mark&sweep        */
;*    collectors for basic blocks.                                     */
;*---------------------------------------------------------------------*/
(define (assert-blocks b::blockS lbl)
   (when *bbv-debug*
      (let loop ((bs (list b))
		 (set (make-empty-bbset)))
	 (cond
	    ((null? bs)
	     set)
	    ((bbset-in? (car bs) set)
	     (loop (cdr bs) set))
	    (else
	     (with-access::blockS (car bs) (succs)
		(assert-block (car bs) lbl)
		(loop (append succs (cdr bs))
		   (bbset-cons (car bs) set))))))))

;*---------------------------------------------------------------------*/
;*    assert-context! ...                                              */
;*    -------------------------------------------------------------    */
;*    Insert assertion to verify dynamically the correction of the     */
;*    specialized CFG.                                                 */
;*---------------------------------------------------------------------*/
(define (assert-context! b::block)
   
   (define (pragma-ins cexpr::bstring ctx loc)
      (let ((pgm (instantiate::rtl_pragma
		    (format cexpr))))
	 (instantiate::rtl_ins/bbv
	    (loc loc)
	    (fun pgm)
	    (ctx ctx)
	    (args '()))))
   
   (define (reg-debugname reg::rtl_reg)
      (with-access::rtl_reg reg (var debugname)
	 (cond
	    (debugname
	     debugname)
	    ((global? var)
	     (with-access::global var (id module alias)
		(bigloo-module-mangle (symbol->string (or alias id))
		   (symbol->string module))))
	    ((local? var)
	     (with-access::local var (id key)
		(bigloo-mangle
		   (string-append
		      (symbol->string id) "_" (integer->string key)))))
	    (else
	     (symbol->string (gensym 'bbv))))))
   
   (define (type-predicate type)
      (cond
	 ((eq? type *long*) "INTEGERP")
	 ((eq? type *real*) "FLONUMP")
	 ((eq? type *vector*) "VECTORP")
	 ((eq? type *pair*) "PAIRP")
	 (else #f)))
   
   (define (type-predicates types)
      (when (pair? types)
	 (filter (lambda (x) x) (map type-predicate types))))
   
   (define (failure pred reg loc)
      (with-access::rtl_reg reg (debugname)
	 (if (location? loc)
	     (format "(fprintf(stderr, \"*** BBV-ERROR:%s:%d\\n%s: %s::%s (%s:%d)\\n\", __FILE__, __LINE__, \"~a\", \"~a\", BSTRING_TO_STRING(bgl_typeof(~a)), \"~a\", ~a), exit(127), 0)"
		pred debugname debugname (location-fname loc) (location-pos loc))
	     (format "(fprintf(stderr, \"*** BBV-ERROR:%s:%d\\n%s: %s::%s\\n\", __FILE__, __LINE__, \"~a\", \"~a\", BSTRING_TO_STRING(bgl_typeof(~a))), exit(127), 0)"
		pred debugname debugname))))
   
   (define (ctx-assert ctx::bbv-ctx loc)
      (with-access::bbv-ctx ctx (entries)
	 (let ((checks (filter-map (lambda (e)
				      (with-access::bbv-ctxentry e (reg types polarity)
					 (with-access::rtl_reg reg (debugname name var type)
					    (set! debugname (reg-debugname reg))
					    (when (eq? type *obj*)
					       (let ((preds (type-predicates types)))
						  (when (pair? preds)
						     (format "~( && )"
							(map (lambda (p)
								(format "(~a~a(~a) || ~a)"
								   (if polarity "" "!")
								   p
								   debugname
								   (failure p reg loc)))
							   preds)
							ctx loc)))))))
			  entries)))
	    (when (pair? checks)
	       (format "~( \n         && )" checks)))))
   
   
   (define (assert-ins i::rtl_ins/bbv first)
      (when (or first (>fx *bbv-assert* 1))
	 (with-access::rtl_ins/bbv i (loc ctx)
	    (let ((assert (ctx-assert ctx loc)))
	       (when (string? assert)
		  (with-access::bbv-ctx ctx (entries)
		     (pragma-ins assert ctx loc)))))))
   
   (assert-blocks b "before assert!")
   (if (>fx *bbv-assert* 0)
       (let loop ((bs (list b))
		  (acc (make-empty-bbset)))
	  (cond
	     ((null? bs)
	      b)
	     ((bbset-in? (car bs) acc)
	      (loop (cdr bs) acc))
	     (else
	      (with-access::block (car bs) (first succs preds label)
		 (when *bbv-debug* (assert-block (car bs) "assert-context!"))
		 (let loop ((first first)
			    (acc '()))
		    (if (null? first)
			(block-first-set! (car bs) (reverse! acc))
			(let ((ins (assert-ins (car first) (null? acc))))
			   (loop (cdr first)
			      (if ins
				  (cons* (car first) ins acc)
				  (cons (car first) acc))))))
		 (loop (append succs (cdr bs)) (bbset-cons (car bs) acc))))))
       b))
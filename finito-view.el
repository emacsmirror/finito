;;; finito-view.el --- Graphical parts of finito -*- lexical-binding: t -*-

;; Copyright (C) 2021 Laurence Warne

;; Author: Laurence Warne

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; This file contains transients used by finito.

;;; Code:

(require 's)
(require 'transient)

;;; Transients

(defclass finito--transient-argument (transient-argument) ())

(cl-defmethod transient-format-value ((obj finito--transient-argument))
  (let ((value (oref obj value)))
    (propertize (concat (oref obj argument)
                        (if (listp value)
                            (mapconcat #'identity value ",")
                          value))
                'face (if value
                          'transient-value
                        'transient-inactive-value))))

;; We always want a value to show up in ARGS for a transient arg function, so
;; we return the empty string instead of nil, since nil implies an unspecified
;; value
;; TODO can I get an alist/plist instead?
(cl-defmethod transient-infix-value ((obj finito--transient-argument))
  "Return the value of OBJ's `value' slot."
  (or (oref obj value) ""))

;;; Infix Arguments

(define-infix-argument finito--title-arg ()
  :class 'finito--transient-argument
  :key "t"
  :argument "title=")

(define-infix-argument finito--author-arg ()
  :class 'finito--transient-argument
  :key "a"
  :argument "author=")

(define-infix-argument finito--isbn-arg ()
  :class 'finito--transient-argument
  :key "i"
  :argument "isbn=")

(define-infix-argument finito--max-results-arg ()
  :class 'finito--transient-argument
  :key "n"
  :argument "max results=")

;;; Prefixes

(transient-define-prefix finito-dispatch ()
  "Search for books."
  ["Actions"
   ("m" "My Books"          ignore)
   ("r" "Currently Reading" ignore)
   ("s" "Search"            finito-search)
   ("c" "Collections"       finito-collection)])

(transient-define-prefix finito-search ()
  "Search for books."
  ["Variables"
   (finito--title-arg :description "Title" :prompt "Title: ")
   (finito--author-arg :description "Author" :prompt "Author: ")
   (finito--isbn-arg :description "ISBN" :prompt "ISBN: ")
   (finito--max-results-arg :description "Max Results" :prompt "Max results: ")]
  ["Actions"
   ;("c" "Copy Curl"     finito-request)
   ("s" "Search"        finito-request)])

(transient-define-prefix finito-collection ()
  "Search for books."
  ["Actions"
   ;("c" "Copy Curl"     finito-request)
   ("n" "Create a new Collection" ignore)
   ("o" "Open a Collection"       ignore)
   ("d" "Delete a Collection"     ignore)
   ("i" "Import a Collection"     ignore)
   ("e" "Export a Collection"     ignore)])

(provide 'finito-view)
;;; finito-view.el ends here

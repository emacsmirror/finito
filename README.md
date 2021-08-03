# finito.el

`finito.el` allows for the management of books from within Emacs.  Books are presented in modified org mode buffers, and books along with user collections can be viewed/queried using [transient](https://github.com/magit/transient).

This package is a thin client for https://github.com/laurencewarne/libro-finito, more information on collection management and customization can be found there.

# Installation

```elisp
(use-package finito
  :quelpa (finito :fetcher github :repo "LaurenceWarne/finito.el" :stable t)
  :bind ("C-c b" . finito-dispatch)
  :config
  ;; You can also download the server jar manually from the releases page:
  ;; https://github.com/LaurenceWarne/libro-finito/releases and place it in
  ;; `finito-server-directory'
  (finito-download-server-if-not-exists))
```

# Customisation

## `finito-writer-instance`

This object can be used to customize how books are written into finito buffers.  The `finito-book-writer` class can be extended to provide ad-hoc customization.  Example:

```elisp
(defclass my-book-writer (finito-book-writer)
  nil
  "My class for writing book information to a buffer.")

(cl-defmethod finito-insert-title ((_writer my-book-writer) title)
  (insert (concat "* " title "\n\n")))

(setq finito-writer-instance (my-book-writer))
```

This writer class will insert titles as level one headings, and otherwise behave exactly the same way as the default writer.

## `finito-my-books-collection`

This variable holds the name of the collection to open when the "My Books" suffix is invoked from the `finito-dispatch` prefix command.

It can be changed to some other user created collection, though note its default value ("My Books") is marked as a [special collection](https://github.com/LaurenceWarne/libro-finito#special-collections) (by default) by the server - more specifically the **default** collection which automatically adds all books added to any other collection or started/completed/rated to itself.

Therefore, once you have:

```elisp
(setq finito-my-books-collection "good books, some say the greatest")
```

In order to accumulate all added books you will have to mark it as a special collection and add hook (or not if you prefer books not be added automagically everywhere).

## `finito-currently-reading-collection`

This variable holds the name of the collection to open when the "Currently Reading" suffix is invoked from the `finito-dispatch` prefix command.

The situation is similar to that of `finito-my-books-collection` above in that the default value "Currently Reading" is regarded as a special collection, though only books marked as "started" will be added to this collection.

## Misc Variables

| Variable                 | Description                                                 |
|--------------------------|-------------------------------------------------------------|
| `finito-language`        | The languge search queries should request responses in      |
| `finito-image-cache-dir` | The directory to cache book images                          |
| `finito-browse-function` | The function to be invoked by `finito-browse-book-at-point` |

More information is available via `C-h v`.

# Similar Packages

## [org-books](https://github.com/lepisma/org-books)

## [calibredb.el](https://github.com/chenyanming/calibredb.el)

# README

```
$ git clone ...
$ bundle install
$ rails s
```

* Visit localhost:3000/works to see html erb working as expected.

* Visit localhost:3000/fails to see haml failing to escape inline JS.

* ActionView's **content_for** sanitizes its input and marks it as html_safe.

* Check rails server logs to see that when **content_for** is used to set values inside haml, it fails to sanitize when it contains broken tags.

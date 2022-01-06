# Legacy notice

`nimlibxlsxwriter` was originally developed by KeepCoolWithCoolidge using
`nimgen`. Since then development of `nimgen` was deprecated and Github changed
master branch name to `main`.

`nimgen` had the external git repo branch hardcoded to `master`, which became
a problem when the C-library `libxlsxwriter` changed its branch name to `main`.

It has been a hassle to update but was partly resolved in https://github.com/ThomasTJdev/nimlibxlsxwriter/pull/4
and Genotrace was so kind to merge a pull request in `nimgen`: https://github.com/genotrance/nimgen/pull/50.


# Reason

Personally I have no need for using `nimlibxlsxwriter` on Windows, so I have
decided to remove that support. That can be categorized as a breaking change...

To give a fair notice I created the issue https://github.com/ThomasTJdev/nimlibxlsxwriter/issues/6
on the 26th og Juli 2021 with one month deadline before merging the Linux-only-PR.

I have now waited for 6 months due to using the package locally with no problem.
But *now* it's time! It's time because we have gotten another XLSX-package in
the Nimble library!


# What to do

Well, if this gives you trouble place open an issue on the GitHub repo. If you
want to use `nimgen`, then you have it right here! But no support from me.

```bash
$ nimgen nimlibxlsxwriter.cfg
```
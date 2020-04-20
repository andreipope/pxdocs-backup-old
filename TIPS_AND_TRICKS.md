## Editing content

Each page is written in [Markdown](https://daringfireball.net/projects/markdown/syntax) and uses [front-matter](https://gohugo.io/content-management/front-matter/) in YAML format to describe the page.

The important fields in the front-matter are as follow:

 * `title` - the name of the page and the name that will appear on the menu
 * `weight` - what order the page will appear in the menu and previous & next links within sections

#### Sections

The menu on the left hand side is build from the `section` pages.  A section is created by making `_index.md` file within a folder.

You can make sections within sections by placing folders with `_index.md` files recursively in a folder tree - the menu will render the sections into the same tree represented by the folders.

#### Reusing content

To re-use the same content across multiple pages - we use the `content` shortcode.  Here is an example from the kubernetes installation section where there are multiple sections re-using the same page content:

```
---
title: 2. Secure ETCD and Certificates
weight: 2
---

{{% content "portworx-install-with-kubernetes/shared/2-secure-etcd-and-certificates.md" %}}
```

This page will live inside it's section but render the content from the `portworx-install-with-kubernetes/shared/2-secure-etcd-and-certificates.md` file.

To create a section that has shared content but is not rendered in the tree (like the `shared` folder in the example above) - we use the `hidden` value of the front-matter.  Here is the `_index.md` for the shared section that provides the content files used above:


```
---
title: Shared
hidden: true
---

Shared content for kubernetes installation
```

This means we can add files into the `shared` folder but they won't show up in the menu.

#### Linking between sections

Pages within a section will display **next** and **previous** links based on the `weight` property of the front-matter.  Sometimes it's useful to put a manual link into a page (or shared content) to keep the flow going.

Use the `widelink` shortcode to do this as follows:

```
{{< widelink url="/application-install-with-kubernetes" >}}Stateful applications on Kubernetes{{</widelink>}}
```

This will render the wide orange links to the page url given.

#### Section homepages

The `_index.md` page of a section can contain content and it will list all of the pages and/or sections that live below it.

You can disable the list of child links using the `hidesections` property of the front-matter in the `_index.md` page - then it will only render the section page content.

#### Redirects

To control redirecting from old page URLs to new pages - you must put a `redirect_from` parameter into the front-matter of the new page.

An example to redirect two stale URLs to a page:

```yaml
---
title: 1. Prepare your platform
weight: 1
redirect_from:
  - /cloud/azure/k8s_tectonic.html
  - /apples/pears.html
---
```

#### Updating the HEAD meta tags (title, keywords & description)

To change the site HEAD meta tags - change the following values in `config.yaml`:

 * title
 * params.description
 * params.keywords

## hugo docs

Because the site is based on hugo - you can use any of the shortcodes, functions and variables listed in the [hugo documentation](https://gohugo.io/documentation/)

#### publish site

If you want to generate the built website locally - you can:

```bash
make publish
```

This will generate a `public` folder in which the static docs website for the current version branch is placed.
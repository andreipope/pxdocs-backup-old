## Algolia search

If you want the Algolia search bar to be activated locally for testing - you will need to export the following variables - get these from an administrator:

```bash
export ALGOLIA_APP_ID=XXX
export ALGOLIA_API_KEY=XXX
export ALGOLIA_ADMIN_KEY=XXX
export ALGOLIA_INDEX_NAME=local-backup
```

Then you will need to update the remote algolia index with the contents of the site:

```bash
make search-index
```

Finally run `make develop` as normal and the algolia search bar should display with the content of the site indexed.

You can always re-run the `make search-index` command again to re-index.
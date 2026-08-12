# Gitea Credential And Issue Workflow

## Resolve The Origin

Inspect the remote before any external write:

```bash
git remote get-url origin
```

For this repository, the expected internal instance is:

```text
http://192.168.1.76:3000/howard/PRetrieval_forked.git
```

Parse the actual origin rather than assuming the owner or repository. Never
substitute `upstream` for `origin`.

## Inspect Credential Persistence

Check the active helper:

```bash
git config --show-origin --get-all credential.helper
```

`cache --timeout=28800` is temporary: the credential expires after eight
hours and is also lost when the credential-cache process stops.

## Configure Permanent Storage

Only switch the global helper when the user asks for permanent storage:

```bash
git config --global --unset-all credential.helper
git config --global credential.helper store

read -s -p "Gitea token: " GITEA_TOKEN
echo

printf 'protocol=http\nhost=192.168.1.76:3000\nusername=howard\npassword=%s\n\n' \
  "$GITEA_TOKEN" | git credential approve

unset GITEA_TOKEN
chmod 600 ~/.git-credentials
```

Explain that `store` persists credentials across restarts but writes them in
plaintext to `~/.git-credentials`. The `chmod 600` step limits filesystem
access to the current user. Prefer an OS-backed encrypted helper when one is
installed and the user wants encrypted storage.

Confirm only the helper mode; never display the credential file:

```bash
git config --show-origin --get-all credential.helper
```

## Use The Saved Credential Safely

Supply only the lookup fields to Git:

```text
protocol=http
host=192.168.1.76:3000
username=howard
```

Call `git credential fill` from an in-memory script and parse its output
without printing it. Construct the authenticated request inside that process,
then discard the credential variables. Do not put a token in a command-line
URL, source file, issue body, or tool output.

## Create An Issue

1. List open and closed issues using:
   `GET /api/v1/repos/{owner}/{repo}/issues?state=all&limit=100`.
2. Compare the requested title and obvious equivalents before writing.
3. Create only if no matching issue exists:
   `POST /api/v1/repos/{owner}/{repo}/issues`.
4. Send a JSON body containing `title` and `body`.
5. Read the response and report `number` and `html_url`.
6. Fetch the created issue once more when verification is material.

If creation fails after the POST may have reached the server, repeat the
duplicate check before retrying.

## Attachments And Gitea 1.17

Check `/api/v1/version` and `/swagger.v1.json` before calling an attachment
endpoint. Gitea 1.17.3 does not expose the later issue-assets REST endpoint:

```text
POST /api/v1/repos/{owner}/{repo}/issues/{index}/assets
```

Its browser UI uploads through CSRF/session-protected Web routes instead.
A personal access token accepted by the REST API does not by itself create a
browser login session. Therefore:

- Use a screenshot as local evidence when drafting the issue even if it cannot
  be attached through the installed REST API.
- Do not repeatedly retry the unsupported REST endpoint.
- Do not create a release, repository commit, or third-party upload merely to
  obtain an image URL.
- If the image must be attached, report the version limitation and ask for an
  authorized browser-session upload or an approved alternative.

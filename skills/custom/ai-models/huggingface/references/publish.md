# Publishing

Before a remote write, confirm:

- exact `owner/name` repository and whether it already exists;
- user authorization for creation or overwrite;
- declared license, intended use, limitations, and task metadata;
- required config, tokenizer or processor, and weight files;
- large-file handling and total upload size;
- source revision and local file checksums when reproducibility matters.

After upload, retrieve the resulting repository metadata or file listing and
return the verified Hub URL. Never infer success from a command starting.

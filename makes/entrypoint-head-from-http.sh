# shellcheck shell=bash

function extract_tar {
  local in="${1}"
  local out="${2}"

  info Extracting to "${out}" \
    && mkdir -p "${out}" \
    && tar -xf "${in}" -C "${out}"
}

function main {
  local mime
  local artifact
  local url="${1}"
  local out="${2}"

  info Downloading "${url}" \
    && artifact="$(mktemp)" \
    && curl -Lo "${artifact}" "${url}" \
    && mime="$(file --mime-type --brief "${artifact}")" \
    && case "${mime}" in
      application/gzip) extract_tar "${artifact}" "${out}" ;;
      *) error Unsupported mime type: "${mime}" ;;
    esac
}

main "${@}"

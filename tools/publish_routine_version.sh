#!/usr/bin/env bash
set -euo pipefail

ROUTINE_DIR="/home/ubuntu/habit_tracker/reference"
ACTIVE_POINTER="${ROUTINE_DIR}/routine_workout.active.json"
LEGACY_CURRENT="${ROUTINE_DIR}/routine_workout.json"

VERSION=""
EFFECTIVE_FROM=""
PDF_PATH=""
JSON_PATH=""
NOTES=""
UPDATE_LEGACY_CURRENT="false"

usage() {
  cat <<'USAGE'
Usage:
  publish_routine_version.sh \
    --version YYYY-MM \
    --effective-from YYYY-MM-DD \
    --pdf /abs/path/plan.pdf \
    --json /abs/path/parsed_routine.json \
    [--notes "optional notes"] \
    [--update-legacy-current]

Behavior:
  - Copies the provided parsed JSON into:
      /home/ubuntu/habit_tracker/reference/routine_workout_<version>.json
  - Updates:
      /home/ubuntu/habit_tracker/reference/routine_workout.active.json
  - Does not overwrite existing versioned files.
  - Optionally refreshes legacy routine_workout.json for backwards compatibility.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      VERSION="${2:-}"
      shift 2
      ;;
    --effective-from)
      EFFECTIVE_FROM="${2:-}"
      shift 2
      ;;
    --pdf)
      PDF_PATH="${2:-}"
      shift 2
      ;;
    --json)
      JSON_PATH="${2:-}"
      shift 2
      ;;
    --notes)
      NOTES="${2:-}"
      shift 2
      ;;
    --update-legacy-current)
      UPDATE_LEGACY_CURRENT="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "${VERSION}" || -z "${EFFECTIVE_FROM}" || -z "${PDF_PATH}" || -z "${JSON_PATH}" ]]; then
  echo "Missing required arguments." >&2
  usage
  exit 1
fi

if [[ ! -f "${PDF_PATH}" ]]; then
  echo "PDF not found: ${PDF_PATH}" >&2
  exit 1
fi

if [[ ! -f "${JSON_PATH}" ]]; then
  echo "Parsed JSON not found: ${JSON_PATH}" >&2
  exit 1
fi

if [[ "${VERSION}" =~ [^0-9-] ]]; then
  echo "Invalid version '${VERSION}'. Use format YYYY-MM." >&2
  exit 1
fi

if [[ ! "${EFFECTIVE_FROM}" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
  echo "Invalid --effective-from '${EFFECTIVE_FROM}'. Use YYYY-MM-DD." >&2
  exit 1
fi

mkdir -p "${ROUTINE_DIR}"

DEST_FILE="${ROUTINE_DIR}/routine_workout_${VERSION}.json"
if [[ -e "${DEST_FILE}" ]]; then
  echo "Version already exists: ${DEST_FILE}" >&2
  echo "Refusing to overwrite immutable versioned routine file." >&2
  exit 1
fi

cp "${JSON_PATH}" "${DEST_FILE}"

UPDATED_AT_UTC="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

cat > "${ACTIVE_POINTER}" <<EOF
{
  "active_version": "routine_workout_${VERSION}.json",
  "effective_from": "${EFFECTIVE_FROM}",
  "source_pdf": "${PDF_PATH}",
  "active_file_path": "${DEST_FILE}",
  "updated_at_utc": "${UPDATED_AT_UTC}",
  "notes": "${NOTES}"
}
EOF

if [[ "${UPDATE_LEGACY_CURRENT}" == "true" ]]; then
  cp "${DEST_FILE}" "${LEGACY_CURRENT}"
fi

echo "Published routine version: ${DEST_FILE}"
echo "Updated active pointer: ${ACTIVE_POINTER}"
if [[ "${UPDATE_LEGACY_CURRENT}" == "true" ]]; then
  echo "Updated legacy current file: ${LEGACY_CURRENT}"
fi

